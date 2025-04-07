#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APPS="bat nala fish btop fd-find ripgrep fzf zoxide alacritty libfuse2"

APP_NAME="apt.cli"
LOG_TMP_FILE=$(mktemp -p "/tmp" "${APP_NAME}.XXXXX.log")
echo ">> Logging to ${LOG_TMP_FILE}"
log2file date

echo ">> Updating ${APP_NAME}..."
log2file sudo apt-get update

echo ">> Installing ${APPS}..."
# shellcheck disable=SC2086
log2file sudo apt-get install ${APPS} -y
