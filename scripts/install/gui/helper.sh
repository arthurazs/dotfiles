latest_version () {
    repo_name=$1
    echo $(curl -s "https://api.github.com/repos/$repo_name/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
}

version_url () {
    repo_name=$1
    app_version=$2
    filename=$3
    echo "https://github.com/$repo_name/releases/download/$app_version/$filename"
}
