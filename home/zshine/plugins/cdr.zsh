autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-file ~/.zsh_recent-dirs +
zstyle ':chpwd:*' recent-dirs-max 50

[[ "$commands[fzf]" ]] || exit
function fzf-cdr () {
    setopt localoptions pipefail
    local dir=$(
        (cdr -l | awk '{print $2}' | uniq | sed 's/\$HOME/~/' ) | fzf --no-multi --query "$LBUFFER"
    )
    if [ -n "$dir" ]; then
    BUFFER="cd $dir"
        zle reset-prompt
        zle accept-line
    fi
}
zle -N fzf-cdr
bindkey "^t" fzf-cdr
