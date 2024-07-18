LOG_TMP_FILE=$(mktemp -p "/tmp" "zed.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

ZED_TMP_DIR=$(mktemp -p "/tmp" -d "zed.XXXXX")
ZED_TMP_TAR="$ZED_TMP_DIR/zed.tar.gz"
ZED_BASE_DIR="$HOME/.local"
ZED_DIR="$ZED_BASE_DIR/zed.app"
ZED_APPID="dev.zed.Zed"

echo ">> Downloading latest zed..." | tee -a $LOG_TMP_FILE
wget "https://zed.dev/api/releases/stable/latest/zed-linux-x86_64.tar.gz" -O "$ZED_TMP_TAR" -a $LOG_TMP_FILE
echo ">> Deleting old zed..." | tee -a $LOG_TMP_FILE
rm -vrf $ZED_DIR >> $LOG_TMP_FILE
echo ">> Extracting tar..." | tee -a $LOG_TMP_FILE
tar -vxzf "$ZED_TMP_TAR" -C "$ZED_BASE_DIR" >> $LOG_TMP_FILE
echo ">> Linking zed to path..." | tee -a $LOG_TMP_FILE
ln -vsf "$ZED_DIR/bin/zed" "$ZED_BASE_DIR/bin/zed" >> $LOG_TMP_FILE

ZED_DESKTOP_FILE_PATH="$ZED_BASE_DIR/share/applications/$ZED_APPID.desktop"
echo ">> Creating launcher for zed..." | tee -a $LOG_TMP_FILE
cp -v "$ZED_DIR/share/applications/zed.desktop" $ZED_DESKTOP_FILE_PATH >> $LOG_TMP_FILE
echo ">> Fixing launcher values..." >> $LOG_TMP_FILE
sed -i "s|Icon=zed|Icon=$ZED_DIR/share/icons/hicolor/512x512/apps/zed.png|g" $ZED_DESKTOP_FILE_PATH >> $LOG_TMP_FILE
sed -i "s|Exec=zed|Exec=$ZED_DIR/libexec/zed-editor|g" $ZED_DESKTOP_FILE_PATH >> $LOG_TMP_FILE

echo ">> Removing tmp dir..." | tee -a $LOG_TMP_FILE
rm -vrf $ZED_TMP_DIR >> $LOG_TMP_FILE

