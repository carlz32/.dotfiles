## Dotfiles

### Requirements

- zsh 
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [brew](https://brew.sh/)
- [tmux](https://github.com/tmux/tmux)
- [neovim](https://github.com/neovim/neovim)
- [stow](https://github.com/aspiers/stow)
- visual studio code
    - settings.json
    - keybindings.json


### Steps

```bash
git clone --recursive https://github.com/Carl-ZLJ/.dotfiles ~/.dotfiles
cd ~/.dotfiles
stow .
```