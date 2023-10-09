for d in /opt/asdf-vm /opt/homebrew/opt/asdf/libexec; do
    [[ -f "$d/asdf.sh" ]] || continue

    export ASDF_DATA_DIR=~/.local/share/asdf
    export ASDF_CONFIG_FILE=~/.config/asdfrc

    source "$d/asdf.sh"
done
unset d
