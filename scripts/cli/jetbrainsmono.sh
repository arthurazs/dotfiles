#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="JetBrainsMono"
APP_REPO="ryanoasis/nerd-fonts"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
EXTENSION="tar.xz"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$EXTENSION"
APP_BASE_DIR="$HOME/.local/share/fonts"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(github_latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}.$EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -o "$APP_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..."
log2file tar -xJf "$APP_TMP_FILE" -C "$APP_TMP_DIR"

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file mkdir -p -v "$APP_BASE_DIR"
log2file mv -v "$APP_TMP_DIR/${APP_NAME}NerdFont-Regular.ttf" "$APP_BASE_DIR"
log2file fc-cache -f -r

echo ">> Removing tmp dir..."
log2file rm -rf "$APP_TMP_DIR"
