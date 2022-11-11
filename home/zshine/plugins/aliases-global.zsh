#!/usr/bin/env zsh

# run less or cat, depending on terminal/pipe position
function global-aliases:less() {
    if [[ -t 1 ]]; then
        command less -XR
    else
        command cat
    fi
}

# run python function over variable "line"
function global-aliases:python() {
    python3 -c \
        "import sys, re; from signal import signal, SIGPIPE, SIG_DFL; signal(SIGPIPE, SIG_DFL); sys.stdout.write('\n'.join([$@ for line in [x.strip() for x in sys.stdin.readlines()]])); sys.stdout.write('\n')"
}

# show AWK columns
function global-aliases:awk-n() {
    local args=()
    for arg in "${@}"; do
        if grep -xqE "([0-9]+|.*NF.*)" <<< "$arg"; then
            args+=("\$($arg)")
        else
            args+=("\"${arg}\"")
        fi
    done
    awk "{print ${(j:,:)args[@]}}"
}

alias -g -- :a,='| awk -F,'
alias -g -- :a/='| awk -F/'
alias -g -- :a:='| awk -F:'
alias -g -- :a='| awk'
alias -g -- :an='| global-aliases:awk-n'
alias -g -- :c='| cut -d'
alias -g -- :g='| grep -E'
alias -g -- :gi='| grep -Ei'
alias -g -- :gv='| grep -Ev'
alias -g -- :h='| head -n'
alias -g -- :l='| global-aliases:less'
alias -g -- :nonempty="| awk NF"
alias -g -- :p='| perl -pe'
alias -g -- :py='| global-aliases:python'
alias -g -- :s='| sed -E'
alias -g -- :t='| tail -n'
alias -g -- :td='| tr -d'
alias -g -- :tr='| tr'
alias -g -- :u="| awk '!x[\$0]++'"
alias -g -- :uc="| sort | uniq -c | sort -n"
alias -g -- :2null="2>/dev/null"
alias -g -- :1null=">/dev/null"
alias -g -- :21="2>&1"
