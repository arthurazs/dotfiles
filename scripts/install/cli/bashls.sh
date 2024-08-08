#!/bin/bash

APP_NAME="bash-language-server"  # bashls
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME lastest version..." | tee -a "$LOG_TMP_FILE"
sudo snap install bash-language-server --classic >> "$LOG_TMP_FILE"
