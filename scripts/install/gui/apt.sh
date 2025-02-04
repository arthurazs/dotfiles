#!/bin/bash

RED="\033[31m"
RESET="\033[0m"
set -e # exit on error
trap 'E_STAT=$? && [ "$E_STAT" -ne 0 ] && echo "${RED}ERROR $E_STAT${RESET} in $0 check the log"' EXIT

APPS="gimp gnome-browser-connector foliate"

APP_NAME="apt.gui"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

echo ">> Updating $APP_NAME..." | tee -a "$LOG_TMP_FILE"
sudo apt-get update >>"$LOG_TMP_FILE"

echo ">> Installing $APPS..." | tee -a "$LOG_TMP_FILE"
sudo apt-get install $APPS -y >>"$LOG_TMP_FILE"
