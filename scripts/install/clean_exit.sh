RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"
set -e # exit on error
trap 'E_STAT=$? && [ "$E_STAT" -ne 0 ] && echo "${RED}ERROR $E_STAT${RESET} in $0 check the log" || echo "${GREEN}Done${RESET}"' EXIT

