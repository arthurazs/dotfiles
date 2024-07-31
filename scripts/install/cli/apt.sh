#!/bin/bash

APPS="eza bat nala fish python3-pip btop fd-find ripgrep fzf zoxide git curl"

APP_NAME="apt.cli"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Updating $APP_NAME..." | tee -a $LOG_TMP_FILE
sudo apt-get update >> $LOG_TMP_FILE
echo ">> Installing $APPS..." | tee -a $LOG_TMP_FILE
sudo apt-get install $APPS -y >> $LOG_TMP_FILE

