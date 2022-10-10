#!/usr/bin/env zsh

# default: stored in current directory
export MYPY_CACHE_DIR=~/.cache/mypy

# do not prefix shell prompt with venv name
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ "$commands[ipython]" ]] && export PYTHONBREAKPOINT=IPython.core.debugger.set_trace
[[ "$commands[ipdb]" ]] && export PYTHONBREAKPOINT=ipdb.set_trace
[[ "$commands[pudb]" ]] && export PYTHONBREAKPOINT=pudb.set_trace


# pipenv

# or: pipenv shell
venv() {
    source "$(pipenv --venv)/bin/activate"
}
