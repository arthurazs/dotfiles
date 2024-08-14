#!/bin/bash

. ./../helper.sh

APP_NAME="nvim"
APP_REPO="neovim/neovim"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="tar.gz"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"
BASE_DIR="$HOME/.local"
APP_BASE_DIR="$BASE_DIR/$APP_NAME"

echo ">> Searching for $APP_NAME latest version..." | tee -a "$LOG_TMP_FILE"
APP_VERSION=$(latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}-linux64.$APP_EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
wget "$(version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -O "$APP_TMP_FILE" -a "$LOG_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
{
	tar -xzf "$APP_TMP_FILE" -v -C "$APP_TMP_DIR"
	rm -rfv "$APP_BASE_DIR"
	mv -v "$APP_TMP_DIR/nvim-linux64" "$APP_BASE_DIR"
	ln -vsf "$APP_BASE_DIR/bin/$APP_NAME" "$BASE_DIR/bin/$APP_NAME"
} >>"$LOG_TMP_FILE"

echo ">> Removing tmp dir..." | tee -a "$LOG_TMP_FILE"
rm -vrf "$APP_TMP_DIR" >>"$LOG_TMP_FILE"
