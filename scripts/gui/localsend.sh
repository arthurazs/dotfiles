#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"

APP_NAME="LocalSend"
APP_REPO="localsend/localsend"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="deb"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(github_latest_version $APP_REPO)
APP_VERSION_SHORT=$(echo "$APP_VERSION" | cut -c2-)
APP_FILENAME="${APP_NAME}-${APP_VERSION_SHORT}-linux-x86-64.$APP_EXTENSION"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL \
    "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" \
    -o "$APP_TMP_FILE"

echo ">> Installing dependencies [gir1.2-appindicator3-0.1]..."
log2file sudo apt-get install -y gir1.2-appindicator3-0.1

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file sudo dpkg -i "$APP_TMP_FILE"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
