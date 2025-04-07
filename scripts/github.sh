# Example usage:
# github_latest_version "arthurazs/dotfiles"
# github_version_url "arthurazs/dotfiles" "v1.0.0" "dotfiles.tar.gz"

github_latest_version() {
    repo_name=$1
    curl -s "https://api.github.com/repos/$repo_name/releases/latest" | grep -Po '"tag_name": "\K[^"]*'
}

github_version_url() {
    repo_name=$1
    app_version=$2
    filename=$3
    echo "https://github.com/$repo_name/releases/download/$app_version/$filename"
}
