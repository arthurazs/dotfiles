#!/bin/bash

APPS="uv mypy ruff pyright"

APP_NAME="pip"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Installing $APPS..." | tee -a $LOG_TMP_FILE
pip install --break-system-packages --upgrade $APPS >> $LOG_TMP_FILE

