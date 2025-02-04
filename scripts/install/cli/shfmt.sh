#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
RESET="\033[0m"
set -e # exit on error
trap 'E_STAT=$? && [ "$E_STAT" -ne 0 ] && echo "${RED}ERROR $E_STAT${RESET} in $0 check the log" || echo "${GREEN}Done${RESET}"' EXIT

. ./../helper.sh

APP_NAME="shfmt"
APP_REPO="mvdan/sh"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >>"$LOG_TMP_FILE"

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME"
APP_BASE_DIR="$HOME/.local/bin"

echo ">> Searching for $APP_NAME latest version..." | tee -a "$LOG_TMP_FILE"
APP_VERSION=$(latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}_${APP_VERSION}_linux_amd64"

echo ">> Downloading $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
wget "$(version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -O "$APP_TMP_FILE" -a "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME version $APP_VERSION..." | tee -a "$LOG_TMP_FILE"
{
	mkdir -p -v "$APP_BASE_DIR"
    mv -v "$APP_TMP_FILE" "$APP_BASE_DIR"
    chmod +x "$APP_BASE_DIR/$APP_NAME"
} >>"$LOG_TMP_FILE"

echo ">> Removing tmp dir..." | tee -a "$LOG_TMP_FILE"
rm -vrf "$APP_TMP_DIR" >>"$LOG_TMP_FILE"
