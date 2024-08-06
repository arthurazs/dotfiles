#!/bin/bash

. ./../helper.sh

APP_NAME="wavebox"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="deb"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Downloading $APP_NAME latest version..." | tee -a $LOG_TMP_FILE
wget https://download.wavebox.app/latest/stable/linux/deb -O $APP_TMP_FILE -a $LOG_TMP_FILE

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
sudo dpkg -i $APP_TMP_FILE >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE
