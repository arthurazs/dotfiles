#!/usr/bin/dash

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../clean_exit.sh
. "${PARENT_DIR}/clean_exit.sh"

echo ">> ${YELLOW}WARNING${RESET} are you REALLY sure you want to install npm?"
read -p ">> Do you REALLY wish to proceed? [y/n]: " -r yn
case $yn in
[Yy]*) echo "proceeding..." ;;
[Nn]*) return 0 ;;
*) echo "Invalid answer" && return 2 ;;
esac

APP_NAME="npm"
LOG_TMP_FILE=$(mktemp -p "/tmp" "${APP_NAME}.XXXXX.log")
echo ">> Logging to ${LOG_TMP_FILE}"
date >>"${LOG_TMP_FILE}"

echo ">> Updating ${APP_NAME}..." | tee -a "${LOG_TMP_FILE}"
{
	sudo apt-get update
} >>"${LOG_TMP_FILE}"

echo ">> Installing ${APP_NAME}..." | tee -a "${LOG_TMP_FILE}"
{
	sudo apt-get install "${APP_NAME}" -y
} >>"${LOG_TMP_FILE}"

echo ">> Configuring ${APP_NAME}..." | tee -a "${LOG_TMP_FILE}"
{
    mkdir -pv "${HOME}/.local/npm"
	npm config set prefix "${HOME}/.local/npm"
} >>"${LOG_TMP_FILE}"
