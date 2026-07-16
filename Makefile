.PHONY: fish
fish:
	ln -s /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish config/fish/completions/nix.fish
	@if [ -e ~/.config/fish ] && [ ! -L ~/.config/fish ]; then \
		mv ~/.config/fish ~/.config/fish.bak; \
	fi
	ln -sfn $(CURDIR)/config/fish ~/.config/fish

.PHONY: kitty
kitty:
	@if [ -e ~/.config/kitty ] && [ ! -L ~/.config/kitty ]; then \
		mv ~/.config/kitty ~/.config/kitty.bak; \
	fi
	ln -sfn $(CURDIR)/config/kitty ~/.config/kitty
