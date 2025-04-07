#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="discord"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.deb"

echo ">> Downloading $APP_NAME latest version..."
log2file curl -fsSL "https://discord.com/api/download?platform=linux&format=deb" -o "$APP_TMP_FILE"

echo ">> Installing $APP_NAME..."
log2file sudo dpkg -i "$APP_TMP_FILE"
log2file sudo apt-get install -f -y

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
