#!/bin/bash

APP_NAME="gopls"  # go
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME lastest version..." | tee -a "$LOG_TMP_FILE"
go install golang.org/x/tools/gopls@latest >> "$LOG_TMP_FILE"
