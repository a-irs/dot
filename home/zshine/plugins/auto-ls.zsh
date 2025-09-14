#!/usr/bin/env zsh

chpwd_l() {
    emulate -L zsh
    l
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_l

chpwd_l
