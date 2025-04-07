#!/usr/bin/sh
APP_NAME="xdg"
PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
ROOT_DIR="$(dirname ${PARENT_DIR})"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

NEW_DIRS="Desktop Templates Public Music Videos"

CONFIG_FILENAME="user-dirs.dirs"
CONFIG_DOTFILE_DIR="${ROOT_DIR}/config"
CONFIG_HOME_DIR="$HOME/.config"
CONFIG_IN="$CONFIG_DOTFILE_DIR/${APP_NAME}/$CONFIG_FILENAME"
CONFIG_OUT="$CONFIG_HOME_DIR/$CONFIG_FILENAME"

LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to ${LOG_TMP_FILE}"
log2file date

echo ">> Creating dirs for ${NEW_DIRS}..."
log2file echo "$NEW_DIRS" | tr ' ' '\n' | while read NEW_DIR; do mkdir -p $HOME/.$APP_NAME/$NEW_DIR; done

echo ">> Configuring ${APP_NAME}..."
log2file cp -v $CONFIG_IN $CONFIG_OUT
echo ">> Updating ${APP_NAME}..."
log2file xdg-user-dirs-update
