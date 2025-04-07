#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="rustup" # rust, cargo
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

echo ">> Installing $APP_NAME..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | log2file sh -s -- -y
