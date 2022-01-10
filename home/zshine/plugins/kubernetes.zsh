if [[ $commands[kubectl] ]]; then
    source <(kubectl completion zsh)
fi

if [[ $commands[skaffold] ]]; then
    export SKAFFOLD_UPDATE_CHECK=false
fi
