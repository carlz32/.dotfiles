## Dotfiles

### Requirements

- zsh
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [tmux](https://github.com/tmux/tmux)
- [neovim](https://github.com/neovim/neovim)
- [stow](https://github.com/aspiers/stow)
- Visual Studio Code
  - settings.json
  - keybindings.json
    > Vscode does not support symlinks, so just copy and paste(ignored by **stow**).
- [Hyprland Window Manager](https://wiki.hyprland.org/)
  - kitty
  - dunst
  - nwg-bar
  - waybar
- Zed

### Steps

```bash
git clone -b master --recursive https://github.com/carlz32/.dotfiles ~/.dotfiles
cd ~/.dotfiles
stow .
```
