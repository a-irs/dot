#!/usr/bin/env zsh

# default: stored in current directory
export MYPY_CACHE_DIR=~/.cache/mypy

# do not prefix shell prompt with venv name
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ -e /opt/homebrew/etc/ca-certificates/cert.pem ]] && export REQUESTS_CA_BUNDLE=/opt/homebrew/etc/ca-certificates/cert.pem

[[ "$commands[ipython]" ]] && export PYTHONBREAKPOINT=IPython.core.debugger.set_trace
[[ "$commands[ipdb]" ]] && export PYTHONBREAKPOINT=ipdb.set_trace
[[ "$commands[pudb]" ]] && export PYTHONBREAKPOINT=pudb.set_trace

alias uv="uv --native-tls"  # use system CA store
venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
        return
    fi

    if [[ ! -d .venv ]]; then
        read -q "REPLY?No virtualenv found, create? (y/N) "
        if ! [[ $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
        printf '\n'

        mkdir -p .venv
        if [[ -f setup.py || -f pyproject.toml ]]; then
            if [[ -f uv.lock ]]; then
                uv sync --frozen
            else
                uv sync
            fi
        else
            uv init --no-readme && rm -f hello.py
            uv sync
        fi

        printf '\n%s\n' "----------"
        printf '%s\n' "Created virtualenv in $PWD/.venv"
        printf '%s\n' "----------"

        printf '%s\n' '[[ -z "$VIRTUAL_ENV" ]] && source .venv/bin/activate' >> .env
        printf '\n%s\n' '.env' >> .gitignore
    fi

    source .venv/bin/activate

    printf '%s\n' "Cheatsheet"
    printf '%s\n' "----------"
    printf '%s\n' "uv add <packages>; uv remove <packages>"
    printf '%s\n' "uv sync"
    printf '%s\n' "uv run; uv run python"
}
