#!/bin/bash

APP_NAME="brave-browser"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Downloading $APP_NAME gpg keys..." | tee -a $LOG_TMP_FILE
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg >> $LOG_TMP_FILE

echo ">> Adding $APP_NAME to apt sources list..." | tee -a $LOG_TMP_FILE
sudo bash -c 'echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" > /etc/apt/sources.list.d/brave-browser-release.list'

echo ">> Updating apt..." | tee -a $LOG_TMP_FILE
sudo apt-get update >> $LOG_TMP_FILE
echo ">> Installing $APP_NAME..." | tee -a $LOG_TMP_FILE
sudo apt-get install -y $APP_NAME >> $LOG_TMP_FILE
