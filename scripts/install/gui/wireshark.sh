#!/bin/bash

. ./../clean_exit.sh

APP_NAME="wireshark"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

echo ">> Pre-configuring $APP_NAME..." | tee -a "$LOG_TMP_FILE"
{
	sudo add-apt-repository -y ppa:wireshark-dev/stable
	echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
} >>"$LOG_TMP_FILE"

echo ">> Updating apt..." | tee -a "$LOG_TMP_FILE"
{
	sudo apt-get update
} >>"$LOG_TMP_FILE"

echo ">> Installing $APP_NAME..." | tee -a "$LOG_TMP_FILE"
{
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $APP_NAME
} >>"$LOG_TMP_FILE"

echo ">> Post-configuring $APP_NAME..." | tee -a "$LOG_TMP_FILE"
{
	sudo usermod -a -G wireshark "$USER"
} >>"$LOG_TMP_FILE"
