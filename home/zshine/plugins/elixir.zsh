[[ -z "$commands[elixir]" ]] && return

export ERL_AFLAGS="-kernel shell_history enabled"

iex() {
    if [[ -f mix.exs ]]; then
        command iex -S mix "$@"
    else
        command iex "$@"
    fi
}
