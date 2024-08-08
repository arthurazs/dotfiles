#!/bin/bash

APP_NAME="rust-analyzer"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME..." | tee -a "$LOG_TMP_FILE"
rustup component add "$APP_NAME" >> "$LOG_TMP_FILE"
