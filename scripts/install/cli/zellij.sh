#!/bin/bash

. ./../helper.sh

APP_NAME="zellij"
APP_REPO="zellij-org/zellij"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.tar.gz"
APP_BASE_DIR="$HOME/.local/bin"

echo ">> Searching for $APP_NAME latest version..." | tee -a $LOG_TMP_FILE
APP_VERSION=`latest_version $APP_REPO`
APP_FILENAME="${APP_NAME}-x86_64-unknown-linux-musl.tar.gz"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
wget `version_url $APP_REPO $APP_VERSION $APP_FILENAME` -O $APP_TMP_FILE -a $LOG_TMP_FILE

echo ">> Decompressing $APP_NAME version $APP_VERSION..." | tee -a $LOG_TMP_FILE
tar -xzf $APP_TMP_FILE -v -C $APP_BASE_DIR >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE
