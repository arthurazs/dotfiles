#!/bin/bash

APPS="alacritty gimp gnome-browser-connector"

APP_NAME="apt.gui"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Updating $APP_NAME..." | tee -a $LOG_TMP_FILE
sudo apt-get update >> $LOG_TMP_FILE
echo ">> Installing $APPS..." | tee -a $LOG_TMP_FILE
sudo apt-get install $APPS -y >> $LOG_TMP_FILE
