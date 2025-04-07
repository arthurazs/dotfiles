# files for ubuntu

Tested on ubuntu 24.04.1.

**NOTE** you may need to add your user in the sudoers group with:

```bash
su -
apt install sudo
usermod -a -G sudo <username>
```

---

Contains:

- TODO...
- Split `apt.sh` into multiple scripts
- Copy apt-snap
- Create function for "do you wish to proceed \[y/n\]"
- Add config copying inside instalation script (see cli/go.sh for example), add to nvim too? (it would download another repo)
- Remove all `wget` and `#!/bin/bash` and `RED|YELLOW|ETC`
- Rework `pip.sh` to install only uv from git
- Review ==gui==

## Install Default

```bash
sudo apt install -y curl
curl https://raw.githubusercontent.com/arthurazs/dotfiles/refs/heads/feature/add-gui-scripts/init.sh | sh
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

- [Better Active Tab](https://zen-browser.app/mods/d8b79d4a-6cba-4495-9ff6-d6d30b0e94fe)
- [Better Find Bar](https://zen-browser.app/mods/a6335949-4465-4b71-926c-4a52d34bc9c0)
    - Turn every config off
- [Better Unloaded Tabs](https://zen-browser.app/mods/f7c71d9a-bce2-420f-ae44-a64bd92975ab)
- [Floating Status Bar](https://zen-browser.app/mods/906c6915-5677-48ff-9bfc-096a02a72379)
- [Hide Extension Name](https://zen-browser.app/mods/cb15abdb-0514-4e09-8ce5-722cf1f4a20f)
- [HidePlugins](https://zen-browser.app/mods/b430a958-cd66-4edd-b451-c6c7cfb7e160)
- [No Gaps](https://zen-browser.app/mods/bfcc400a-4ecb-4752-bfd2-a68f116a2722)
    - Turn every config on but
        - Hide top bar in single-tab view (single toolbar)
        - Hide top bar in multi-tab view (single toolbar)
        - Remove top bar in single-tab view (single toolbar)
        - Remove top bar in multi-tab view (single toolbar)
- [No Search Shortcut Icons](https://zen-browser.app/mods/d7076c31-f6c1-4f28-b2e8-15b95f5a3d6f)
- [Now playing indicator](https://zen-browser.app/mods/2e3369c7-e450-46ba-8794-75ccb0de5e48)
- [Only Close on Hover](https://zen-browser.app/mods/4596d8f9-f0b7-4aeb-aa92-851222dc1888)
- [Tab Preview Enhanced](https://zen-browser.app/mods/87196c08-8ca1-4848-b13b-7ea41ee830e7)
- [Zen Context Menu](https://zen-browser.app/mods/81fcd6b3-f014-4796-988f-6c3cb3874db8)
    - Turn every config on but
        - Hide all separators
        - Hide all icons
        - Only use 'Copy Link Without Site Tracking'
        - Hide 'Mute Tab' option
        - Hide 'New Tab' option
        - Hide 'Search Keywords' with your preferred search engine
        - Hide 'Duplicate Tab' option
        - Hide 'Tab Unloader Actions'
        - Hide 'View Page Source' and 'Inspect' options
        - Hide 'Save Link As'

### Extensions

- [bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager)
- [bonjourr](https://addons.mozilla.org/en-US/firefox/addon/bonjourr-startpage)
- [AutoClicker](https://addons.mozilla.org/en-US/firefox/addon/autoclicker-automatic-tap)
- [SponsorBlock](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock)
- [Tampermonkey](https://addons.mozilla.org/en-US/firefox/addon/tampermonkey) for Overleaf
  - [Relative Line](https://gist.github.com/MattHeffNT/006d8040a95e41bb54f13ab932ca9bb0/raw/451376ac79084b9f4a390b63332228692c81d367/relativeNumberOverLeaf.user.js)
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)
- [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)
