#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="librewolf"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

echo ">> Updating apt..."
log2file sudo apt-get update

echo ">> Installing dependencies [extrepo]..."
log2file sudo apt-get install -y extrepo
log2file sudo extrepo enable librewolf

echo ">> Updating apt..."
log2file sudo apt-get update

echo ">> Installing $APP_NAME..."
log2file sudo apt-get install -y "$APP_NAME"
