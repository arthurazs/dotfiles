#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="pyright"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

if ! hash npm 2>/dev/null; then
    echo "${TRAP_RED}npm not found${TRAP_RESET}"
    return 1
fi

echo ">> Installing $APP_NAME lastest version..."
log2file npm i -g "$APP_NAME"
