if status is-interactive
    # inits
    starship init fish | source
    zoxide init --cmd cd fish | source

    # env paths
    set -x CARGO_HOME "$HOME/.local/cargo"
    set -x RUSTUP_HOME "$HOME/.local/rustup"
    set -x R_LIBS "$HOME/.local/lib/R"

    # Emulates vim's cursor shape behavior
    set fish_vi_force_cursor true           # Set the cursor config to custom
    set fish_cursor_default block           # Set the normal and visual mode cursors to a block
    set fish_cursor_insert line             # Set the insert mode cursor to a line
    set fish_cursor_replace_one underscore  # Set the replace mode cursor to an underscore
    set fish_cursor_replace underscore      # Set the replace mode cursor to an underscore
    set fish_cursor_external line           # Set the external cursor to a line.

    # updates manager
    abbr -a apt "sudo nala"
    abbr -a apt-livepatch 'sudo canonical-livepatch refresh'

    # lists
    abbr -a ls      "eza --icons --group-directories-first"
    abbr -a l       "eza --icons --group-directories-first -a"
    abbr -a ll      "eza -l --git --icons -h -g --group-directories-first"
    abbr -a la      "eza -l --git --icons -h -g --group-directories-first -a"
    abbr -a tree    "eza --tree --icons --level 2 --group-directories-first"
    abbr -a dufiles "du -hsc * | sort -h"
    abbr -a dudirs  "du -h --max-depth=1 | sort -h"

    # misc
    abbr -a p "ping 8.8.8.8"

    # text editors/readers
    abbr -a vim "nvim"
    abbr -a vi  "nvim --clean"
    abbr -a cat "batcat"

    # python env
    abbr -a cpenv "uv venv .venv"
    abbr -a apenv "source .venv/bin/activate.fish"
    abbr -a ipenv "uv pip install -e .[dev]"
    abbr -a dpenv "deactivate"
end
