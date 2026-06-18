.PHONY: toggle

KITTY_CONF := $(HOME)/.config/kitty/kitty.conf
ZELLIJ_CONF := $(HOME)/.config/zellij/config.kdl

toggle:
	@if tail -n 1 $(KITTY_CONF) | grep -q 'light'; then \
		sed -i '$$d' $(KITTY_CONF); \
		echo "include dark.conf" >> $(KITTY_CONF); \
		sed -i '$$d' $(ZELLIJ_CONF); \
		echo "theme \"one-dark\"" >> $(ZELLIJ_CONF); \
	else \
		sed -i '$$d' $(KITTY_CONF); \
		echo "include light.conf" >> $(KITTY_CONF); \
		sed -i '$$d' $(ZELLIJ_CONF); \
		echo "theme \"one-light\"" >> $(ZELLIJ_CONF); \
	fi
	@kill -10 $$(pgrep kitty) 2>/dev/null || true
