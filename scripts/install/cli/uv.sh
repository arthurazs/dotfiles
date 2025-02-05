#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"
. /etc/os-release

APP_NAME="uv"
REPO_NAME="astral-sh"
APP_REPO="${REPO_NAME}/${APP_NAME}"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="tar.gz"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"
APP_BASE_DIR="$HOME/.local/bin"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(github_latest_version $APP_REPO)
APP_ARCH="x86_64-unknown-linux-gnu"
APP_FILENAME="${APP_NAME}-${APP_ARCH}.${APP_EXTENSION}"

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -o "$APP_TMP_FILE"

echo ">> Decompressing $APP_NAME version $APP_VERSION..."
log2file tar -xzf "$APP_TMP_FILE" -v -C "$APP_TMP_DIR"

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file mkdir -p -v "$APP_BASE_DIR"
log2file mv -v "$APP_TMP_DIR/${APP_NAME}-${APP_ARCH}/${APP_NAME}" "$APP_BASE_DIR"

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
