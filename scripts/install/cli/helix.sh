#!/bin/bash

. ./../helper.sh

APP_NAME="helix"
APP_REPO="helix-editor/helix"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="AppImage"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Searching for $APP_NAME latest version..." | tee -a "$LOG_TMP_FILE"
APP_VERSION=$(latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}-${APP_VERSION}-x86_64.$APP_EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
wget "$(version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -O "$APP_TMP_FILE" -a "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
{
    chmod -v +x "$APP_TMP_FILE"
    "$APP_TMP_FILE" --appimage-extract
    mv -v "squashfs-root/" "$APP_TMP_DIR"
    mv -v "$APP_TMP_DIR/squashfs-root/Helix.desktop" "$HOME/.local/share/applications/"
    mv -v "$APP_TMP_DIR/squashfs-root/usr/share/icons/hicolor/256x256/apps/helix.png" "$HOME/.local/share/icons/"
    mv -v "$APP_TMP_FILE" "$HOME/.local/bin/hx" 
} >>"$LOG_TMP_FILE"

echo ">> Removing tmp dir..." | tee -a "$LOG_TMP_FILE"
rm -vrf "$APP_TMP_DIR" >>"$LOG_TMP_FILE"
