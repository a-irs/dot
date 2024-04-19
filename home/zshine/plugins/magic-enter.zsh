# inspired by https://github.com/chrisgrieser/zsh-magic-dashboard/blob/main/magic_dashboard.zsh
# run command when buffer is empty and enter is pressed

_magic_enter_run() {
    tput clear

    if git rev-parse --is-inside-work-tree &> /dev/null; then
        if ! git diff-index --quiet HEAD; then
            _trunc 10 git --no-pager -c color.ui=always s
            _sep
        fi

        _trunc 10 git --no-pager -c color.ui=always log --stat --decorate=short --date=relative -1 | perl -0777 -pe 's/(Date: .*)\n\s+(.*)/\1\nBody:   \2/g'
        _sep
    fi

    _trunc 10 ls -l --color=always -CF
}

_sep() {
    local sep_char="─" # ─ ═
    local sep=""
    for ((i = 0; i < COLUMNS; i++)); do
        sep+="$sep_char"
    done
    printf '\n\033[1;30m%s\033[0m' "$sep"
}

_trunc() {
    local limit=$1; shift
    local cmd=$@

    local out=$(eval $cmd)
    printf "$out" | head -10
    if [[ "$(printf "$out" | wc -l)" -gt 10 ]]; then
        printf '\033[1;30m%s\033[0m' "..."  # …
    fi
}


_magic_enter() {
    # run only in PS1 and when BUFFER is empty
    # http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#User_002dDefined-Widgets
    [[ -z "$BUFFER" && "$CONTEXT" == "start" ]] || return 0

    # run only when in terminal with sufficient height
    local disabled_below_height=15
    [[ $LINES -gt $disabled_below_height ]] || return 0

    _magic_enter_run
}

case "${widgets[accept-line]}" in
    user:*)
        # Override the current accept-line widget, calling the old one
        zle -N _magic_enter_orig_accept_line "${widgets[accept-line]#user:}"
        _magic_enter_accept_line() {
            _magic_enter
            zle _magic_enter_orig_accept_line -- "$@"
        }
        ;;

    builtin)
        # If no user widget defined, call the original accept-line widget
        _magic_enter_accept_line() {
            _magic_enter
            zle .accept-line
        }
        ;;
esac

zle -N accept-line _magic_enter_accept_line
