#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="brave-browser"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

echo ">> Downloading $APP_NAME gpg keys..."
log2file sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo ">> Adding $APP_NAME to apt sources list..."
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |
    sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null

echo ">> Updating apt..."
log2file sudo apt-get update

echo ">> Installing $APP_NAME..."
log2file sudo apt-get install -y $APP_NAME
