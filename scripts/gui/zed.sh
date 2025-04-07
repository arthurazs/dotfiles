#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

LOG_TMP_FILE=$(mktemp -p "/tmp" "zed.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "zed.XXXXX")
APP_TMP_TAR="$APP_TMP_DIR/zed.tar.gz"
APP_BASE_DIR="$HOME/.local"
APP_DIR="$APP_BASE_DIR/zed.app"
APP_APPID="dev.zed.Zed"

echo ">> Downloading latest zed..."
log2file curl -fsSL \
    "https://zed.dev/api/releases/stable/latest/zed-linux-x86_64.tar.gz" \
    -o "$APP_TMP_TAR"

echo ">> Deleting old zed..."
log2file rm -vrf "$APP_DIR"

echo ">> Extracting tar..."
log2file tar -vxzf "$APP_TMP_TAR" -C "$APP_BASE_DIR"

echo ">> Linking zed to path..."
log2file ln -vsf "$APP_DIR/bin/zed" "$APP_BASE_DIR/bin/zed"

ZED_DESKTOP_FILE_PATH="$APP_BASE_DIR/share/applications/$APP_APPID.desktop"
echo ">> Creating launcher for zed..."
log2file cp -v "$APP_DIR/share/applications/zed.desktop" "$ZED_DESKTOP_FILE_PATH"

echo ">> Fixing launcher values..."
log2file sed -i "s|Icon=zed|Icon=$APP_DIR/share/icons/hicolor/512x512/apps/zed.png|g" \
    "$ZED_DESKTOP_FILE_PATH"
log2file sed -i "s|Exec=zed|Exec=$APP_DIR/libexec/zed-editor|g" \
    "$ZED_DESKTOP_FILE_PATH"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
