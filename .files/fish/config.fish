if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    alias apt="sudo nala"
    alias cat="batcat"
    alias glow="glow -p"
    alias ls="exa --icons --group-directories-first"
    alias l="ls -a"
    alias ll="exa -l --git --icons --color-scale -h -g --group-directories-first"
    alias la="ll -a"
    alias tree="exa --tree --icons --level 2 --group-directories-first"
    alias find="fdfind"
    alias cd="z"
end
