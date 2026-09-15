[[ -z "$commands[emacs]" ]] && return

path+=(~/.config/emacs/bin)

# --alternate-editor="" start emacs in daemon mode when not running already
alias em="emacsclient --create-frame --alternate-editor='' --tty"
