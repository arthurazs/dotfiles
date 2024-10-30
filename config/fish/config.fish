if status is-interactive
    # Commands to run in interactive sessions can go here
    alias apt="sudo nala"
    alias ls="eza --icons --group-directories-first"
    alias l="ls -a"
    alias ll="eza -l --git --icons -h -g --group-directories-first"
    alias la="ll -a"
    alias tree="eza --tree --icons --level 2 --group-directories-first"
    alias apt-livepatch='sudo canonical-livepatch refresh'
    alias dufiles="du -hsc * | sort -h"
    alias dudirs="du -h --max-depth=1 | sort -h"
    alias vim="nvim"
    alias vi="nvim --clean"
    alias p="ping 8.8.8.8"
    alias cat="batcat"
    starship init fish | source
    zoxide init --cmd cd fish | source

    # python env
    alias cpenv="uv venv"
    alias apenv=". .venv/bin/activate.fish"
    alias ipenv="uv pip install -e .[dev]"
    alias dpenv="deactivate"

    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line

    set -x CARGO_HOME "$HOME/.local/cargo"
    set -x RUSTUP_HOME "$HOME/.local/rustup"
end
