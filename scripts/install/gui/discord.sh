#!/bin/bash

. ./../clean_exit.sh

APP_NAME="discord"
APP_URL="https://discord.com/api/download?platform=linux&format=deb"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.deb"

echo ">> Downloading $APP_NAME latest version..." | tee -a "$LOG_TMP_FILE"
wget "$APP_URL" -O "$APP_TMP_FILE" -a "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME..." | tee -a "$LOG_TMP_FILE"
{
	sudo dpkg -i "$APP_TMP_FILE"
	sudo apt-get install -f -y
} >>"$LOG_TMP_FILE"

echo ">> Removing tmp dir..." | tee -a "$LOG_TMP_FILE"
rm -vrf "$APP_TMP_DIR" >>"$LOG_TMP_FILE"
