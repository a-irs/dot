#!/usr/bin/env zsh

add-zsh-hook chpwd (){ emulate -L zsh; l; }
