.PHONY: fish kitty zellij starship

CONFIG_DIR := $(HOME)/.config

fish:
	ln -s /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish config/fish/completions/nix.fish
	@if [ -e $(CONFIG_DIR)/fish ] && [ ! -L $(CONFIG_DIR)/fish ]; then \
		mv $(CONFIG_DIR)/fish $(CONFIG_DIR)/fish.bak; \
	fi
	ln -sfn $(CURDIR)/config/fish $(CONFIG_DIR)/fish

kitty:
	@if [ -e $(CONFIG_DIR)/kitty ] && [ ! -L $(CONFIG_DIR)/kitty ]; then \
		mv $(CONFIG_DIR)/kitty $(CONFIG_DIR)/kitty.bak; \
	fi
	ln -sfn $(CURDIR)/config/kitty $(CONFIG_DIR)/kitty

zellij:
	@if [ -e $(CONFIG_DIR)/zellij ] && [ ! -L $(CONFIG_DIR)/zellij ]; then \
		mv $(CONFIG_DIR)/zellij $(CONFIG_DIR)/zellij.bak; \
	fi
	ln -sfn $(CURDIR)/config/zellij $(CONFIG_DIR)/zellij

starship:
	@if [ -e $(CONFIG_DIR)/starship.toml ] && [ ! -L $(CONFIG_DIR)/starship.toml ]; then \
		mv $(CONFIG_DIR)/starship.toml $(CONFIG_DIR)/starship.toml.bak; \
	fi
	ln -sfn $(CURDIR)/config/starship/starship.toml $(CONFIG_DIR)/starship.toml
