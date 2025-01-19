#!/bin/bash

echo ">> WARNING: This will download an unofficial version of Ghostty"
read -p ">> do you wish to proceed? [y/n]: " -r yn
case $yn in
    [Yy]*) echo "proceeding...";;
    [Nn]*) echo "Aborted"; return 0;;
    *) echo "Invalid answer"; return 2;;
esac

. /etc/os-release
. ./../helper.sh

APP_NAME="ghostty"
APP_REPO="mkasberg/ghostty-ubuntu"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="deb"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Searching for $APP_NAME latest version..." | tee -a "$LOG_TMP_FILE"
APP_VERSION=$(latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}_${APP_VERSION}_amd64_${VERSION_ID}.$APP_EXTENSION"
APP_FILENAME=$(echo "$APP_FILENAME" | sed "s/-/./2")

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
wget "$(version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -O "$APP_TMP_FILE" -a "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
{
	sudo dpkg -i "$APP_TMP_FILE"
	sudo apt-get install -f -y
} >>"$LOG_TMP_FILE"

echo ">> Removing tmp dir..." | tee -a "$LOG_TMP_FILE"
rm -vrf "$APP_TMP_DIR" >>"$LOG_TMP_FILE"
