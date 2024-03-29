#!/usr/bin/env zsh

setopt nobeep

zmodload zsh/terminfo

os="$OSTYPE"

# safe paste https://github.com/zsh-users/zsh/blob/master/Functions/Zle/bracketed-paste-magic
set zle_bracketed_paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# no duplicate entries for path arrays
typeset -gU cdpath fpath mailpath path

# add external bin paths to PATH
for p (~/.bin ~/.cargo/bin ~/.bin/$HOST ~/.rd/bin /usr/share/bcc/tools); do
    [[ -d "$p" ]] && path=("$p" $path)
done
unset p

# load prompt
fpath+=($ZSHINE_DIR/prompts)
autoload -U promptinit && promptinit
setopt prompt_subst && prompt zshine

# zmv file-renaming
autoload -U zmv

zstyle ':completion:*' rehash true # always rehash on completion

export GREP_COLOR='mt=1;32'
if [[ "$os" == darwin* ]]; then
    export GREP_COLOR='1;32'
fi
export TZ='Europe/Vienna'
export REPORTTIME=5

[[ $commands[less] ]] && export PAGER=less
[[ $commands[vi] ]]   && export EDITOR=vi
[[ $commands[vim] ]]  && export EDITOR=vim
[[ $commands[nvim] ]] && export EDITOR=nvim

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

setopt NOTIFY # Report status of background jobs immediately.
unsetopt BG_NICE # Dont run all background jobs at a lower priority.
unsetopt HUP # Dont kill jobs on shell exit.
unsetopt CHECK_JOBS # Dont report on jobs when shell exit.
setopt LONG_LIST_JOBS # list jobs in the long format (with pid etc.)
setopt HIST_IGNORE_ALL_DUPS # dont add duplicate dommands
setopt HIST_IGNORE_SPACE # do not add commands starting with space to history
setopt HIST_NO_STORE # do not add 'history' command to history
setopt HIST_REDUCE_BLANKS # strip spaces etc. when adding to history
setopt HIST_VERIFY # safe history expansion
setopt EXTENDED_HISTORY # add time stamps to history
setopt SHARE_HISTORY # immediately add to history and share with other shells
setopt NOTIFY
setopt HASH_CMDS
setopt HASH_LIST_ALL
setopt COMPLETEINWORD
setopt NOCHECKJOBS
setopt NOHUP
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVECOMMENTS
setopt GLOBDOTS
setopt MULTIOS
unsetopt CORRECTALL
unsetopt CORRECT

RESET=$(tput sgr0)
BOLD=$(tput bold)

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREY=$(tput setaf 8)

BOLD_BLACK=${BOLD}${BLACK}
BOLD_RED=${BOLD}${RED}
BOLD_GREEN=${BOLD}${GREEN}
BOLD_YELLOW=${BOLD}${YELLOW}
BOLD_BLUE=${BOLD}${BLUE}
BOLD_MAGENTA=${BOLD}${MAGENTA}
BOLD_CYAN=${BOLD}${CYAN}
BOLD_WHITE=${BOLD}${WHITE}
BOLD_GREY=${BOLD}${GREY}

source "$ZSHINE_DIR/init-plugins.zsh"
