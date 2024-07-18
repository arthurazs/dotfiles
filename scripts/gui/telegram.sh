APP_NAME="telegram"
LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

APP_TMP_DIR=$(mktemp -p "/tmp" -d "$APP_NAME.XXXXX")
APP_TMP_TAR="$APP_TMP_DIR/$APP_NAME.tar.xz"
APP_BASE_DIR="$HOME/.local"

echo ">> Downloading latest $APP_NAME..." | tee -a $LOG_TMP_FILE
wget "https://telegram.org/dl/desktop/linux" -O "$APP_TMP_TAR" -a $LOG_TMP_FILE
echo ">> Extracting tar..." | tee -a $LOG_TMP_FILE
tar -vxJf "$APP_TMP_TAR" -C "$APP_TMP_DIR" >> $LOG_TMP_FILE
echo ">> Moving $APP_NAME to path..." | tee -a $LOG_TMP_FILE
mv -v "$APP_TMP_DIR/Telegram/Telegram" "$APP_BASE_DIR/bin/telegram" >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $APP_TMP_DIR >> $LOG_TMP_FILE

