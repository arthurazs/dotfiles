#!/usr/bin/dash

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../clean_exit.sh
. "${PARENT_DIR}/clean_exit.sh"

APPS="eza bat nala fish btop fd-find ripgrep fzf zoxide alacritty libfuse2"

APP_NAME="apt.cli"
LOG_TMP_FILE=$(mktemp -p "/tmp" "${APP_NAME}.XXXXX.log")
echo ">> Logging to ${LOG_TMP_FILE}"
date >>"${LOG_TMP_FILE}"

echo ">> Updating ${APP_NAME}..." | tee -a "${LOG_TMP_FILE}"
{
    sudo apt-get update
} >>"${LOG_TMP_FILE}"

echo ">> Installing ${APPS}..." | tee -a "${LOG_TMP_FILE}"
{
    sudo apt-get install "${APPS}" -y
} >>"${LOG_TMP_FILE}"
