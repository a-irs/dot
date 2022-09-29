#!/usr/bin/env zsh

# run less or cat, depending on terminal/pipe position
function global-aliases:less() {
    if [[ -t 1 ]]; then
        less -XR
    else
        cat
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

alias -g -- :a,='2>&1 | awk -F,'
alias -g -- :a/='2>&1 | awk -F/'
alias -g -- :a:='2>&1 | awk -F:'
alias -g -- :a='2>&1 | awk'
alias -g -- :an='2>&1 | global-aliases:awk-n'
alias -g -- :c='2>&1 | cut -d'
alias -g -- :g='2>&1 | grep -E'
alias -g -- :gi='2>&1 | grep -Ei'
alias -g -- :gv='2>&1 | grep -Ev'
alias -g -- :h='2>&1 | head -n'
alias -g -- :l='2>&1 | global-aliases:less'
alias -g -- :nonempty="2>&1 | awk NF"
alias -g -- :p='2>&1 | perl -pe'
alias -g -- :py='2>&1 | global-aliases:python'
alias -g -- :s='2>&1 | sed -E'
alias -g -- :t='2>&1 | tail -n'
alias -g -- :td='2>&1 | tr -d'
alias -g -- :tr='2>&1 | tr'
alias -g -- :u="2>&1 | awk '!x[\$0]++'"
alias -g -- :uc="2>&1 | sort | uniq -c | sort -n"
