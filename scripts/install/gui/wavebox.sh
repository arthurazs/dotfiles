#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="wavebox"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="deb"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Downloading $APP_NAME latest version..."
log2file curl -fsSL \
    "https://download.wavebox.app/latest/stable/linux/deb" \
    -o "$APP_TMP_FILE"

echo ">> Installing $APP_NAME latest version..."
log2file sudo dpkg -i "$APP_TMP_FILE"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
