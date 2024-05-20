# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export SUDO_EDITOR="nvim"


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


ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh


# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ap="alias | fzf"
alias tldrf="tldr --list | fzf --preview 'tldr {1}' --preview-window=right:70% | xargs tldr"
alias vi="nvim"
alias psp="ps x | fzf"
alias rate="rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist"
alias hp="history | fzf"
alias phone="scrcpy --video-codec=h264 -m1980 --max-fps=60 -K"

# eza
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


# zoxide
eval "$(zoxide init --cmd cd zsh)"


# fnm
eval "$(fnm env --use-on-cd)"


function killp() {
	if [[ `uname` == "Linux" ]]; then
		ps ax --forest | fzf | awk "{print \$1}" | xargs kill -9
	elif [[ `uname` == "Darwin" ]]; then
		ps ax | fzf | awk "{print \$1}" | xargs kill -9
	fi
}


# move to directory found with fzf
# if passing file, move to dir of there
function cdp() {
	local P
	if [[ $PWD = $HOME ]]; then
		P=$(find ./ $1 -maxdepth 3 ! -path "*/.*" | cat | fzf | sed "s|~|$HOME|")
	else
		P=$(find ./ $1 -maxdepth 4 ! -path "*/.*" | cat | fzf | sed "s|~|$HOME|")
	fi
	if test -d $P; then
		cd $P
	else
		cd $(dirname $P)
	fi
}


# open file found with fzf in vim
function vimp() {
	if git rev-parse 2> /dev/null; then
		vim $(git ls-files | fzf)
	else
		vim $(find ./ $1 -maxdepth 3 | fzf)
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


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

