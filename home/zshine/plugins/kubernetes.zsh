if [[ $commands[kubectl] ]]; then
    source <(kubectl completion zsh)  # TODO: cache this!
    alias k=kubectl
fi

if [[ $commands[helm] ]]; then
    source <(helm completion zsh)
fi
