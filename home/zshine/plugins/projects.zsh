p-cd() {
    cd "$p"
}

p-start() {
    pwd > ~/.project
    _p-load
}

p-stop() {
    rm ~/.project
    unset p
    deactivate 2>/dev/null || true
    cd
}

_p-load() {
    if [[ -f ~/.project ]]; then
        p=$(< ~/.project)
        hash -d p=$p
        cd ~p
    fi
}
_p-load
