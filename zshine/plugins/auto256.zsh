# Set 256color terminal mode if available

_zsh_terminal_set_256color() {
    [[ $TERM =~ "-256color$" ]] && return
    for terminfos in "${HOME}/.terminfo" "/etc/terminfo" "/lib/terminfo" "/usr/share/terminfo" ; do
        if [[ -e "$terminfos"/$TERM[1]/${TERM}-256color || -e "$terminfos"/${TERM}-256color ]] ; then
            export TERM="${TERM}-256color"
            return
        fi
    done
}
_zsh_terminal_set_256color
unset -f _zsh_terminal_set_256color
