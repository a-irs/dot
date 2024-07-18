[[ $commands[docker] ]] || return

if [[ -z "$functions[_docker]" && ! -f "$ZSHINE_CACHE_DIR/completion/_docker" ]]; then
    echo "Creating $ZSHINE_CACHE_DIR/completion/_docker"
    docker completion zsh > "$ZSHINE_CACHE_DIR/completion/_docker"
    compinit
fi
