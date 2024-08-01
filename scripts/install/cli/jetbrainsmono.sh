#!/bin/bash

. ./../helper.sh

APP_NAME="JetBrainsMono"
APP_REPO="ryanoasis/nerd-fonts"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
EXTENSION="tar.xz"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$EXTENSION"
APP_BASE_DIR="$HOME/.local/share/fonts"

echo ">> Searching for $APP_NAME latest version..." | tee -a $LOG_TMP_FILE
APP_VERSION=`latest_version $APP_REPO`
APP_FILENAME="${APP_NAME}.$EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
wget `version_url $APP_REPO $APP_VERSION $APP_FILENAME` -O $APP_TMP_FILE -a $LOG_TMP_FILE

echo ">> Decompressing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
tar -xJf $APP_TMP_FILE -v -C $APP_TMP_DIR >> $LOG_TMP_FILE

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
mkdir -p -v $APP_BASE_DIR >> $LOG_TMP_FILE
mv -v $APP_TMP_DIR/${APP_NAME}NerdFont-Regular.ttf $APP_BASE_DIR >> $LOG_TMP_FILE
fc-cache -f -r >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE
