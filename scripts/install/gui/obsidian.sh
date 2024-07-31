#!/bin/bash

. ./../helper.sh

APP_NAME="obsidian"
APP_REPO="obsidianmd/obsidian-releases"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.deb"
APP_BASE_DIR="$HOME/.local"

echo ">> Searching for $APP_NAME latest version..." | tee -a $LOG_TMP_FILE
APP_VERSION=`latest_version $APP_REPO`
APP_VERSION_SHORT=$(echo $APP_VERSION | cut -c2-)
APP_FILENAME="${APP_NAME}_${APP_VERSION_SHORT}_amd64.deb"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
wget `version_url $APP_REPO $APP_VERSION $APP_FILENAME` -O $APP_TMP_FILE -a $LOG_TMP_FILE

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
sudo dpkg -i $APP_TMP_FILE >> $LOG_TMP_FILE
sudo apt-get install -f >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE

