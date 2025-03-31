#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="helix"
APP_REPO="helix-editor/helix"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="AppImage"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(github_latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}-${APP_VERSION}-x86_64.$APP_EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -o "$APP_TMP_FILE"

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file chmod +x "$APP_TMP_FILE"
log2file "$APP_TMP_FILE" --appimage-extract
log2file mv "squashfs-root/" "$APP_TMP_DIR"
log2file mv -v "$APP_TMP_DIR/squashfs-root/Helix.desktop" "$HOME/.local/share/applications/"
log2file mv -v "$APP_TMP_DIR/squashfs-root/usr/share/icons/hicolor/256x256/apps/helix.png" "$HOME/.local/share/icons/"
log2file mv -v "$APP_TMP_FILE" "$HOME/.local/bin/hx"

echo ">> Removing tmp dir..."
log2file rm -rf "$APP_TMP_DIR"
