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
> Vscode does not support symlinks, so just copy and paste(ignored by stow).


### Steps

```bash
git clone --recursive https://github.com/Carl-ZLJ/.dotfiles ~/.dotfiles
cd ~/.dotfiles
stow .
```