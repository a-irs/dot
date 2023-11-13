#!/usr/bin/env zsh

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ l; }
