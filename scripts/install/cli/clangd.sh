#!/bin/bash

APP="clangd"

APP_NAME=$APP
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

echo ">> Updating $APP_NAME..." | tee -a "$LOG_TMP_FILE"
sudo apt-get update | tee -a "$LOG_TMP_FILE" > /dev/null

echo ">> Installing $APP..." | tee -a "$LOG_TMP_FILE"
sudo apt-get install $APP -y | tee -a "$LOG_TMP_FILE" > /dev/null
