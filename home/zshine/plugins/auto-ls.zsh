#!/usr/bin/env bash

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ l; }
