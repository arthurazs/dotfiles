if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    alias apt="sudo nala"
    alias cat="batcat"
    alias glow="glow -p"
    alias apt-snap="~/apps/./clean_snap.sh"
    alias ls="eza --icons --group-directories-first"
    alias l="ls -a"
    alias ll="eza -l --git --icons --color-scale -h -g --group-directories-first"
    alias la="ll -a"
    alias tree="eza --tree --icons --level 2 --group-directories-first"
    alias find="fdfind"
    alias cd="z"
end
