NEW_DIRS="Desktop Templates Public Music Videos"

APP_NAME="xdg"
CONFIG_FILENAME="user-dirs.dirs"
CONFIG_DOTFILE_DIR="../../config"
CONFIG_HOME_DIR="$HOME/.config"
CONFIG_IN="$CONFIG_DOTFILE_DIR/${APP_NAME}/$CONFIG_FILENAME"
CONFIG_OUT="$CONFIG_HOME_DIR/$CONFIG_FILENAME"

LOG_TMP_FILE=$(mktemp -p "/tmp" "$APP_NAME.XXXXX.log")
echo ">> Logging to $LOG_TMP_FILE"
date >> $LOG_TMP_FILE

echo ">> Creating dirs for $NEW_DIRS..." | tee -a $LOG_TMP_FILE
echo "$NEW_DIRS" | tr ' ' '\n' | while read NEW_DIR; do
    mkdir -p $HOME/.$APP_NAME/$NEW_DIR
done

echo ">> Configuring $APP_NAME..." | tee -a $LOG_TMP_FILE
cp -v $CONFIG_IN $CONFIG_OUT >> $LOG_TMP_FILE
echo ">> Updating $APP_NAME..." | tee -a $LOG_TMP_FILE
xdg-user-dirs-update >> $LOG_TMP_FILE
