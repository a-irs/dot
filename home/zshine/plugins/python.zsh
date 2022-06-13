#!/usr/bin/env zsh

# default: stored in current directory
export MYPY_CACHE_DIR=~/.cache/mypy

# do not prefix shell prompt with venv name
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ "$commands[ipython]" ]] && export PYTHONBREAKPOINT=IPython.core.debugger.set_trace
[[ "$commands[ipdb]" ]] && export PYTHONBREAKPOINT=ipdb.set_trace
[[ "$commands[pudb]" ]] && export PYTHONBREAKPOINT=pudb.set_trace

alias i=ipython

venv() {
    [[ -n "$VIRTUAL_ENV" ]] && { deactivate; return; }
    [[ $# != 1 ]] && { echo "venv <name>"; return 2; }
    local e=$1

    if [[ -d "$e" ]]; then
        if [[ -f "$e/bin/activate" ]]; then
            source "$e/bin/activate"
        else
            echo "$e already exists and is not a venv"
            return 3
        fi
    else
        python3 -m venv "$e" && source "$e/bin/activate"
    fi
}
