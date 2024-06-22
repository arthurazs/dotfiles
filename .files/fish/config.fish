if status is-interactive
	# Commands to run in interactive sessions can go here
	set -gx PATH $HOME/.local/bin
	starship init fish | source
	zoxide init --cmd cd fish | source
	alias apt="sudo nala"
	alias cat="batcat"
	alias apt-snap="~/apps/./clean_snap.sh"
	alias ls="eza --icons --group-directories-first"
	alias l="ls -a"
	alias ll="eza -l --git --icons --color-scale -h -g --group-directories-first"
	alias la="ll -a"
	alias tree="eza --tree --icons --level 2 --group-directories-first"
	alias find="fdfind"
	alias poweroff="sudo poweroff"
	alias reboot="sudo reboot"
	alias vi="vim -u ~/.config/vi/init.lua"
	alias apt-livepatch='sudo canonical-livepatch refresh'
	alias 2dark="ln -fs ~/.config/alacritty/themes/one_dark.toml ~/.config/alacritty/themes/active.toml"
	alias 2light="ln -fs ~/.config/alacritty/themes/github_light.toml ~/.config/alacritty/themes/active.toml"
	alias dufiles="du -hsc * | sort -h"
	alias dudirs="du -h --max-depth=1 | sort -h"
	alias cpenv="uv venv"
	alias apenv=". .venv/bin/activate.fish"
	alias p="ping 8.8.8.8"
end
