#!/bin/bash

. ./../helper.sh

APP_NAME="go"
APP_CONFIG="go.fish"
EXTENSION="tar.gz"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> "$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$EXTENSION"
APP_BASE_DIR="$HOME/.local"

echo ">> Searching for $APP_NAME latest version..." | tee -a "$LOG_TMP_FILE"
APP_VERSION=$(curl -s "https://go.dev/VERSION?m=text" | head -n1)
APP_FILENAME="${APP_VERSION}.linux-amd64.$EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
wget "https://go.dev/dl/${APP_FILENAME}" -O "$APP_TMP_FILE" -a "$LOG_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
tar -xzf "$APP_TMP_FILE" -v -C "$APP_TMP_DIR" >> "$LOG_TMP_FILE"

echo ">> Removing old $APP_NAME version..."
rm -rfv "${APP_BASE_DIR:?}/${APP_NAME}" >> "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
mkdir -p -v "$APP_BASE_DIR" >> "$LOG_TMP_FILE"
mv -v "${APP_TMP_DIR}/${APP_NAME}" "$APP_BASE_DIR" >> "$LOG_TMP_FILE"

echo ">> Configuring $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
mkdir -p -v "${APP_BASE_DIR:?}/go/bin" "${APP_BASE_DIR:?}/gopath/bin" >> "$LOG_TMP_FILE"
cp -v "../../../config/fish/${APP_CONFIG}" "$HOME/.config/fish/conf.d/${APP_CONFIG}" >> "$LOG_TMP_FILE"

echo ">> Removing tmp dir..." | tee -a "$LOG_TMP_FILE"
rm -vrf "$APP_TMP_DIR" >> "$LOG_TMP_FILE"
