#!/usr/bin/env zsh

load-env() {
    emulate -L zsh

    # only whitelisted paths
    if [[ "$PWD" == ~/projects/* || "$PWD" == ~/Documents/* ]]; then
        [[ -f .env ]] && source .env
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd load-env
