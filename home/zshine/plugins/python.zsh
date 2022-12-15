#!/usr/bin/env zsh

# default: stored in current directory
export MYPY_CACHE_DIR=~/.cache/mypy

# do not prefix shell prompt with venv name
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ "$commands[ipython]" ]] && export PYTHONBREAKPOINT=IPython.core.debugger.set_trace
[[ "$commands[ipdb]" ]] && export PYTHONBREAKPOINT=ipdb.set_trace
[[ "$commands[pudb]" ]] && export PYTHONBREAKPOINT=pudb.set_trace

# hide message: "Pipenv found itself running within a virtual environment, so it will automatically use that environment, instead of creating its own for any project."
export PIPENV_VERBOSITY=-1

# pipenv

# or: pipenv shell
venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
        return
    fi

    local venv=$(pipenv --venv)
    if [[ -z "$venv" ]]; then
        pipenv install --site-packages --dev --ignore-pipfile
        venv=$(pipenv --venv)
    fi
    source "$venv/bin/activate"
}
