# Example usage:
# log2file echo "Bye"
# log2file <command>

log2file() {
    {
        echo ">> $*"
        "$@"
        echo ""
    } 1>>"$LOG_TMP_FILE"
}
