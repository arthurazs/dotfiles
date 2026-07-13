.PHONY: fish
fish:
	ln -s /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish ~/.config/fish/completions/nix.fish
	ln -s ~/git/dotfiles/config/fish ~/.config/fish
