if [[ $commands[kubectl] ]]; then
    source <(kubectl completion zsh)
    alias k=kubectl
fi

if [[ $commands[helm] ]]; then
    source <(helm completion zsh)
fi
