# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export SUDO_EDITOR="nvim"
# export DISPLAY=127.0.0.1:0


# python
export PATH=$HOME/.local/bin:$PATH


# plugins
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf
	gh
	rust
)


source $ZSH/oh-my-zsh.sh


# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ap="alias | fzf"
alias tldrf="tldr --list | fzf --preview 'tldr {1}' --preview-window=right:70% | xargs tldr"
alias vi="nvim"
alias psp="ps x | fzf"
alias emacs="emacsclient -c -n -a 'emacs'"


# exa
alias ll="eza --long --icons"
alias la="ll -a --no-user --no-time"
alias lt="la --tree --level=2"


# Node package manager
alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias lint="nr lint"
alias lintf="nr lint --fix"


# oh my posh
eval "$(oh-my-posh init zsh --config /mnt/c/Users/KaelZhu/OneDrive/Documents/Backups/catppuccin.omp.json)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

function killp() {
	if [[ `uname` == "Linux" ]]; then
		ps ax --forest | peco | awk "{print \$1}" | xargs kill -9
	elif [[ `uname` == "Darwin" ]]; then
		ps ax | peco | awk "{print \$1}" | xargs kill -9
	fi
}


# move to directory found with peco
# if passing file, move to dir of there
function cdp() {
	local P
	if [[ $PWD = $HOME ]]; then
		P=$(find ./ $1 -maxdepth 3 ! -path "*/.*" | cat | peco --layout=bottom-up | sed "s|~|$HOME|")
	else
		P=$(find ./ $1 -maxdepth 4 ! -path "*/.*" | cat | peco --layout=bottom-up | sed "s|~|$HOME|")
	fi
	if test -d $P; then
		cd $P
	else
		cd $(dirname $P)
	fi
}


# open file found with peco in vim
function vimp() {
	if git rev-parse 2> /dev/null; then
		vim $(git ls-files | peco --layout=bottom-up)
	else
		vim $(find ./ $1 -maxdepth 3 | peco)
	fi
}


# open with vscode
function c() {
	if [[ -n $1 ]] then
        code $1
	else
        local P=$(find ./ -maxdepth 2 ! -path "*/.*" | cat | fzf --layout=reverse)
        if [[ -z $P ]] then
            echo "[Info]: No file or folder selected!"
        else 
            code $P
        fi
	fi
}


function take() {
  mkdir $1 && cd $1
}

# auto ll after cd into a directory
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd () {
    if [[ $PWD != $HOME ]]; then
        la
    fi
}


function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# pnpm
export PNPM_HOME="/home/kaelz/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


# bun completions
[ -s "/home/kaelz/.bun/_bun" ] && source "/home/kaelz/.bun/_bun"

# opam configuration
test -r /home/kaelz/.opam/opam-init/init.zsh && . /home/kaelz/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# fnm
export PATH="/home/carl/.local/share/fnm:$PATH"
eval "`fnm env`"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
