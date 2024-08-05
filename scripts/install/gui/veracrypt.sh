#!/bin/bash

. ./../helper.sh

APP_NAME="veracrypt"
APP_REPO="veracrypt/VeraCrypt"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="deb"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Searching for $APP_NAME latest version..." | tee -a $LOG_TMP_FILE
APP_VERSION=`latest_version $APP_REPO`
APP_VERSION_SHORT=$(echo $APP_VERSION | cut -c11-)
APP_FILENAME="${APP_NAME}-${APP_VERSION_SHORT}-Ubuntu-24.04-amd64.$APP_EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
wget `version_url $APP_REPO $APP_VERSION $APP_FILENAME` -O $APP_TMP_FILE -a $LOG_TMP_FILE

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
sudo dpkg -i $APP_TMP_FILE >> $LOG_TMP_FILE

echo ">> Fixing apt missing dependencies..." | tee -a $LOG_TMP_FILE
sudo apt-get install -f -y >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE
