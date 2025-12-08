#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="nvim"
APP_REPO="neovim/neovim"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="tar.gz"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"
BASE_DIR="$HOME/.local"
APP_BASE_DIR="$BASE_DIR/$APP_NAME"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(github_latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}-linux-x86_64.$APP_EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -o "$APP_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..."
log2file tar -xzf "$APP_TMP_FILE" -C "$APP_TMP_DIR"
log2file rm -rf "$APP_BASE_DIR"
log2file mv "$APP_TMP_DIR/nvim-linux-x86_64" "$APP_BASE_DIR"
log2file mkdir -p "$BASE_DIR/bin"
log2file ln -vsf "$APP_BASE_DIR/bin/$APP_NAME" "$BASE_DIR/bin/$APP_NAME"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
