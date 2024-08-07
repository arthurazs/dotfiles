#!/bin/bash

. ./../helper.sh

APP_NAME="lua-language-server"
APP_REPO="LuaLS/lua-language-server"
EXTENSION="tar.gz"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$EXTENSION"
APP_BASE_DIR="$HOME/.local/bin"

echo ">> Searching for $APP_NAME latest version..." | tee -a $LOG_TMP_FILE
APP_VERSION=`latest_version $APP_REPO`
APP_FILENAME="${APP_NAME}-${APP_VERSION}-linux-x64.$EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
wget `version_url $APP_REPO $APP_VERSION $APP_FILENAME` -O $APP_TMP_FILE -a $LOG_TMP_FILE

echo ">> Decompressing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
tar -xzf $APP_TMP_FILE -v -C $APP_TMP_DIR >> $LOG_TMP_FILE

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
mkdir -p -v $APP_BASE_DIR >> $LOG_TMP_FILE
mv -v $APP_TMP_DIR/bin/${APP_NAME} $APP_BASE_DIR >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE
