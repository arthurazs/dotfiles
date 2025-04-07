#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

# APPS="uv mypy ruff pyright"
APPS="uv"

APP_NAME="pip"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

echo ">> Installing $APPS..." | tee -a "$LOG_TMP_FILE"
# shellcheck disable=SC2086
log2file pip install --break-system-packages --upgrade $APPS
