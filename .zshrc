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
	docker
	gh
	rust
)


source $ZSH/oh-my-zsh.sh


# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ap="alias | fzf"


# exa
alias ll="exa --long --icons"
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


# vscode profile
alias dug="du -h / 2>/dev/null | grep '[0-9\.]\+G'"
alias tldrf="tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right:70% | xargs tldr"
alias vi="nvim"


# oh my posh
eval "$(oh-my-posh init zsh --config /mnt/c/Users/KaelZhu/OneDrive/Documents/Backups/catppuccin.omp.json)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# node version manager 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# fzf
alias psp="ps x | fzf"


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


# ignore duplicates from history
# function fzf-select-history() {
#    local tac
#    if which tac > /dev/null; then
#    	tac="tac"
#    else
#    	tac="tail -r"
#    fi
#    BUFFER=$(history -n 1 | eval $tac | awk '!a[$0]++' | fzf)
#    CURSOR=$#BUFFER
# }


# zle -N fzf-select-history
# bindkey '^r' fzf-select-history


function take() {
  mkdir $1 && cd $1
}


function cx() {
  cd $1 && ll
}

# zellij work with peco to attach sessions
function new-session() {
  read NAME\?"New session name: "
  if [[ -z $NAME ]] then
    echo "[Info]: set session name to default"
    zellij attach -c "default"
  else
    zellij attach -c "${NAME}"
  fi
}


# function be() {
#   ZJ_SESSIONS=$(zellij list-sessions -s)
#   NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)
# 
#   if [ "{$ZELLIJ}" ] && [ -z "${ZELLIJ_SESSION_NAME}" ]; then
#     if [ "${NO_SESSIONS}" -ge 1 ]; then
#       local P=$(echo "${ZJ_SESSIONS}" | fzf --height 40%)
#       if [[ -z $P ]] then
#         echo "[Info]: no session selected!"
#         new-session
#       else
#         zellij attach $P
#       fi
#     else
#       new-session
#     fi
#   else
#     echo "[Info]: already in session!"
#   fi
# }


function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# pnpm
export PNPM_HOME="/home/kaelz/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kaelz/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kaelz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kaelz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kaelz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# bun completions
[ -s "/home/kaelz/.bun/_bun" ] && source "/home/kaelz/.bun/_bun"

# opam configuration
test -r /home/kaelz/.opam/opam-init/init.zsh && . /home/kaelz/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
