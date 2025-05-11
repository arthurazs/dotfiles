# files for ubuntu

Tested on ubuntu 25.04.

Contains:

- TODO...
- [ ] add install script for eza
- Copy apt-snap
- Add config copying inside instalation script (see cli/go.sh for example), add to nvim too? (it would download another repo)
- Remove all `wget` and `#!/bin/bash` and `RED|YELLOW|ETC`
- Rework `pip.sh` to install only uv from git
- Review ==gui==

### Live Ubuntu

Commands to run:

**Always**

```bash
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed false && dconf write /org/gnome/shell/extensions/dash-to-dock/intellihide true
```

**Once**

```bash
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
echo 'kernel.apparmor_restrict_unprivileged_userns = 0' | sudo tee /etc/sysctl.d/20-apparmor-donotrestrict.conf
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```

## Install Default

The following will install this repo on `$HOME/git/dotfiles`. You may change that by adding `DF_ROOT=/path/to/save` before the `curl` command.

```bash
sudo apt install -y curl && curl https://raw.githubusercontent.com/arthurazs/dotfiles/refs/heads/feature/add-gui-scripts/init.sh | sh
```

### Commands to test

- apt fetch, apt update
- fish
- cat README.md
- l, ls, ll, la, tree
- fdfind -e md
- cd dotfiles
- ==TODO== procs
- rg install.sh
- lazygit
- zellij
- vim, vi

## GNOME Shells 

Recomendations:

- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell)
- [Caffeine](https://extensions.gnome.org/extension/517/caffeine)
- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock)
- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel)
- [Pop Shell](https://support.system76.com/articles/pop-shell)
- [Vitals](https://extensions.gnome.org/extension/1460/vitals)

## Zen

### Mods

Import config/zen/zen-themes-export.json.
- Better Find Bar
    - Check: Transparent Background
    - Vertical position: Top
- Zen Context Menu. Uncheck:
    - Hide all separators
    - Hide all icons
    - \[Tab\] Hide 'Mute Tab' option
    - \[Tab\] Hide 'New Tab' option
    - \[Text\] \[Link\] Hide Firefox's 'Translate Selection/Link' options
    - \[Text\] Hide 'Check Spelling' and 'Change Text/Page Direction' options while typing in text fields
    - \[Page\] \[Text\] Hide 'Select All Text' option
    - \[Tab\] Hide 'Reload Tab' option
    - \[Tab\] Hide 'Duplicate Tab' option
    - \[Tab\] Hide 'Tab Unloader Actions'
    - \[Text\] \[Page\] Hide 'View Page Source' and 'Inspect' options
    - \[Page\] Hide 'Take Screenshot' option
    - \[Image\] Hide 'This Frame' options

### Extensions

- [bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager)
- [bonjourr](https://addons.mozilla.org/en-US/firefox/addon/bonjourr-startpage)
- [AutoClicker](https://addons.mozilla.org/en-US/firefox/addon/autoclicker-automatic-tap)
- [SponsorBlock](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock)
- [Tampermonkey](https://addons.mozilla.org/en-US/firefox/addon/tampermonkey) for Overleaf
  - [Relative Line](https://gist.github.com/MattHeffNT/006d8040a95e41bb54f13ab932ca9bb0/raw/451376ac79084b9f4a390b63332228692c81d367/relativeNumberOverLeaf.user.js)
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)
- [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)
