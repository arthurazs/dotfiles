#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="wireshark"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

echo ">> Pre-configuring $APP_NAME..."
log2file sudo add-apt-repository -y ppa:wireshark-dev/stable
log2file echo "wireshark-common wireshark-common/install-setuid boolean true" | 
    sudo debconf-set-selections

echo ">> Updating apt..."
log2file sudo apt-get update

echo ">> Installing $APP_NAME..."
log2file sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $APP_NAME

echo ">> Post-configuring $APP_NAME..."
log2file sudo usermod -a -G wireshark "$USER"
