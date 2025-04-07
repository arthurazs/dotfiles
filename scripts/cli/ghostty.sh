#!/usr/bin/sh

PARENT_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
# shellcheck source=../trap.sh
. "${PARENT_DIR}/trap.sh"
# shellcheck source=../github.sh
. "${PARENT_DIR}/github.sh"
# shellcheck source=../log.sh
. "${PARENT_DIR}/log.sh"
. /etc/os-release

echo ">> ${TRAP_YELLOW}WARNING${TRAP_RESET} This will download an unofficial version of Ghostty"
printf ">> do you wish to proceed? [y/n]: "
read -r yn
case $yn in
[Yy]*) echo "${TRAP_GREEN}Proceeding...${TRAP_RESET}" ;;
[Nn]*)
    echo "${TRAP_YELLOW}Leaving...${TRAP_RESET}"
    return 0
    ;;
*)
    echo "${TRAP_RED}Invalid answer${TRAP_RESET}"
    return 13
    ;;
esac

APP_NAME="ghostty"
APP_REPO="mkasberg/ghostty-ubuntu"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
log2file date

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_EXTENSION="deb"
APP_TMP_FILE="$APP_TMP_DIR/$APP_NAME.$APP_EXTENSION"

echo ">> Searching for $APP_NAME latest version..."
APP_VERSION=$(github_latest_version $APP_REPO)
APP_FILENAME="${APP_NAME}_${APP_VERSION}_amd64_${VERSION_ID}.$APP_EXTENSION"
APP_FILENAME=$(echo "$APP_FILENAME" | sed "s/-/./2")

echo ">> Downloading $APP_NAME version $APP_VERSION..."
log2file curl -fsSL "$(github_version_url "$APP_REPO" "$APP_VERSION" "$APP_FILENAME")" -o "$APP_TMP_FILE"

echo ">> Installing $APP_NAME version $APP_VERSION..."
log2file sudo dpkg -i "$APP_TMP_FILE"
log2file sudo apt-get install -f -y

echo ">> Removing tmp dir..."
log2file rm -vrf "$APP_TMP_DIR"
