[[ -d /opt/homebrew/opt/asdf ]] && fpath+=(/opt/homebrew/opt/asdf/share/zsh/site-functions)

if [[ "$commands[asdf]" ]]; then
    export ASDF_DATA_DIR=~/.local/share/asdf
    export ASDF_CONFIG_FILE=~/.config/asdfrc
    path=(~/.local/share/asdf/shims $path)
fi
