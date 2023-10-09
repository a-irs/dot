#!/usr/bin/env zsh

if [[ $commands[fd] ]]; then
    export FZF_DEFAULT_COMMAND="fd --hidden --ignore --color never -E .vim/undo -E .vim/plugged -E __pycache__ -E Cache -E .cache -E cache -E .gem -E .npm -E .thumbnails -E .steam -E .local/share/Steam -E .git -E .local/share/containers -E .ansible -E .gradle -E data/ios-backup -E .m2 -E .choosenim -E .stack -E .cabal -E '.local/share/yay/*/src' -E '*.zwc' -E '*.zwc.old' -E '*~' -E '*.pyc' -E node_modules"

    _fzf_compgen_path() {
        eval $FZF_DEFAULT_COMMAND . "$@"
    }
    _fzf_compgen_dir() {
        eval $FZF_DEFAULT_COMMAND --type directory . "$@"
    }
fi
# note: 'rg --files --hidden --no-ignore' is equally fast (benchmarked with hyperfine)

for x in \
    /opt/homebrew/opt/fzf/shell/{key-bindings,completion}.zsh \
    /usr/share/fzf/{key-bindings,completion}.zsh \
    /usr/share/doc/fzf/examples/key-bindings.zsh \
    /usr/share/zsh/vendor-completions/_fzf \
    ; do
    [[ -f "$x" ]] && source "$x"
done
unset x

export FZF_DEFAULT_OPTS='--no-mouse --cycle --ansi --color=16 --inline-info'

export FZF_CTRL_R_OPTS='--exact'
export FZF_ALT_C_OPTS='--preview="s {}" --preview-window "~2"'
export FZF_CTRL_T_OPTS='--preview="s {}" --preview-window "~2"'

export FZF_COMPLETION_TRIGGER='#'
export FZF_COMPLETION_OPTS='--multi --preview="s {}" --preview-window "~2" --delimiter / --nth -1'

fzf() { fzf-tmux -d 50% "$@"; }
