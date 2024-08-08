#!/bin/bash

APP_NAME="rustup"  # cargo
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> "$LOG_TMP_FILE"

echo ">> Installing $APP_NAME..." | tee -a "$LOG_TMP_FILE"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y >> "$LOG_TMP_FILE"

