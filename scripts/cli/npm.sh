#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

echo ">> ${TRAP_YELLOW}WARNING${TRAP_RESET} are you REALLY sure you want to install npm?"
printf ">> do you REALLY wish to proceed? [y/n]: "
read -r yn
case $yn in
[Yy]*) echo "${TRAP_GREEN}Proceeding...${TRAP_RESET}" ;;
[Nn]*)
    echo "${TRAP_YELLOW}Leaving...${TRAP_RESET}"
    return 0
    ;;
*)
    echo "${TRAP_RED}Invalid answer${TRAP_RESET}"
    return 13
    ;;
esac

APP_NAME="npm"
LOG_TMP_FILE=$(mktemp -p "/tmp" "${APP_NAME}.XXXXX.log")
echo ">> Logging to ${LOG_TMP_FILE}"
log2file date

echo ">> Updating ${APP_NAME}..."
log2file sudo apt-get update

echo ">> Installing ${APP_NAME}..."
log2file sudo apt-get install "${APP_NAME}" -y

echo ">> Configuring ${APP_NAME}..."
log2file mkdir -pv "${HOME}/.local/npm"
log2file npm config set prefix "${HOME}/.local/npm"
