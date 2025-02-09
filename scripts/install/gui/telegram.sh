#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="telegram"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_TAR="$APP_TMP_DIR/$APP_NAME.tar.xz"
APP_BASE_DIR="$HOME/.local"

echo ">> Downloading latest $APP_NAME..."
log2file curl -fsSL "https://telegram.org/dl/desktop/linux" -o "$APP_TMP_TAR"

echo ">> Extracting tar..."
log2file tar -vxJf "$APP_TMP_TAR" -C "$APP_TMP_DIR"

echo ">> Moving $APP_NAME to path..."
log2file mv -v "$APP_TMP_DIR/Telegram/Telegram" "$APP_BASE_DIR/bin/telegram"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"

echo "${TRAP_YELLOW}WARNING${TRAP_RESET} Remember to run the command \`telegram\` in the terminal to create the desktop entry"
