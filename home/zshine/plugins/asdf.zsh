[[ -f /opt/asdf-vm/asdf.sh ]] || return 0

export ASDF_DATA_DIR=~/.local/share/asdf
export ASDF_CONFIG_FILE=~/.config/asdfrc

source /opt/asdf-vm/asdf.sh
