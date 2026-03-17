#!/usr/bin/env zsh

_zshine_timewarrior() {

    # show currently active tracking
    local data=~/.local/share/timewarrior/data/$(print -P '%D{%Y-%m}').data
    if [[ -f "$data" ]]; then
        local wc=$(cat "$data" | tail -1 | cut -d '#' -f 1 | wc -w)
        if ((wc < 3)); then
            echo && timew | sed -E "s|Tracking (.*)|Tracking $(tput setaf 4)\1$(tput sgr0)|"
        fi
    fi
}
_zshine_timewarrior
