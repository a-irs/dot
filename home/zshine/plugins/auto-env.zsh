#!/usr/bin/env zsh

load-env() {
    emulate -L zsh

    # only whitelisted paths
    if [[ "$PWD" == ~/projects/* ]]; then
        [[ -f .env ]] && source .env
    fi
}

add-zsh-hook chpwd load-env
