#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="go"
APP_CONFIG="go.fish"
EXTENSION="tar.gz"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$EXTENSION"
APP_BASE_DIR="$HOME/.local"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(curl -s "https://go.dev/VERSION?m=text" | head -n1)
APP_FILENAME="${APP_VERSION}.linux-amd64.$EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "https://go.dev/dl/${APP_FILENAME}" -o "$APP_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..."
log2file tar -xzf "$APP_TMP_FILE" -C "$APP_TMP_DIR"

echo ">> Removing old $APP_NAME version..."
log2file rm -rf "${APP_BASE_DIR:?}/${APP_NAME}"

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file mkdir -p -v "$APP_BASE_DIR"
log2file mv "${APP_TMP_DIR}/${APP_NAME}" "$APP_BASE_DIR"

echo ">> Configuring $APP_NAME version $APP_VERSION..."
log2file mkdir -p -v "${APP_BASE_DIR:?}/go/bin" "${APP_BASE_DIR:?}/gopath/bin"
log2file cp -v "${PARENT_DIR}/../../config/fish/conf.d/${APP_CONFIG}" "$HOME/.config/fish/conf.d/${APP_CONFIG}"

echo ">> Removing tmp dir..."
log2file rm -rf "$APP_TMP_DIR"
