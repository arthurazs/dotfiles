TRAP_RED="\033[31m"
TRAP_GREEN="\033[32m"
# shellcheck disable=SC2034
TRAP_YELLOW="\033[33m"
TRAP_RESET="\033[0m"

set -e # exit on error

cleanup() {
    E_STAT=$?

    if [ -z "$LOG_TMP_FILE" ]; then
        LOG_TMP_FILE=/dev/null
    fi

    {
        if [ "$E_STAT" -ne 0 ]; then
            echo "${TRAP_RED}ERROR $E_STAT${TRAP_RESET} in $0 check the log"
        else
            echo "${TRAP_GREEN}Done${TRAP_RESET}"
        fi
    } | tee -a "$LOG_TMP_FILE"
}
trap cleanup EXIT
