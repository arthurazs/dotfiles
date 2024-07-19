#!/bin/bash

APP_NAME="starship"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Installing $APPS..." | tee -a $LOG_TMP_FILE

echo ">> Installing $APP_NAME..." | tee -a $LOG_TMP_FILE
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y >> $LOG_TMP_FILE

