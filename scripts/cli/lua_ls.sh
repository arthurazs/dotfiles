#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="lua-language-server" # lua_ls
APP_REPO="LuaLS/lua-language-server"
EXTENSION="tar.gz"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$EXTENSION"
BASE_DIR="$HOME/.local"
APP_BASE_DIR="$BASE_DIR/$APP_NAME"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION="$(github_latest_version $APP_REPO)"
APP_FILENAME="${APP_NAME}-${APP_VERSION}-linux-x64.$EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -o "$APP_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..."
log2file mkdir -p -v "$APP_BASE_DIR"
log2file tar -xzf "$APP_TMP_FILE" -C "$APP_BASE_DIR"

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file ln -vsf "$APP_BASE_DIR/bin/$APP_NAME" "$BASE_DIR/bin/$APP_NAME"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
