#!/bin/bash

APP_NAME="librewolf"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Downloading $APP_NAME gpg keys..." | tee -a $LOG_TMP_FILE
wget -q -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/librewolf.gpg >> $LOG_TMP_FILE

echo ">> Adding $APP_NAME to apt sources list..." | tee -a $LOG_TMP_FILE
sudo bash -c 'echo "Types: deb
URIs: https://deb.librewolf.net
Suites: focal
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg" > /etc/apt/sources.list.d/librewolf.sources'

echo ">> Updating apt..." | tee -a $LOG_TMP_FILE
sudo apt-get update >> $LOG_TMP_FILE

echo ">> Installing $APP_NAME..." | tee -a $LOG_TMP_FILE
sudo apt-get install -y $APP_NAME >> $LOG_TMP_FILE
