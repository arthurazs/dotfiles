#!/bin/bash

APP_NAME="apt"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> ATTENTION, THIS SCRIPT WILL ASK FOR YOUR PASSWORD TO RUN APT UPDATE AND APT INSTALL" | tee -a $LOG_TMP_FILE
read -p ">> PRESS ENTER TO CONTINUE" throwaway

echo ">> Updating $APP_NAME..." | tee -a $LOG_TMP_FILE
sudo apt-get update >> $LOG_TMP_FILE
echo ">> Installing alacritty and wavebox..." | tee -a $LOG_TMP_FILE
sudo apt-get install alacritty wavebox -y >> $LOG_TMP_FILE

