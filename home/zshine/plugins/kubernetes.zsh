[[ $commands[kubectl] ]] || return

if [[ -z "$functions[_kubectl]" && ! -f "$ZSHINE_CACHE_DIR/completion/_kubectl" ]]; then
    echo "Creating $ZSHINE_CACHE_DIR/completion/_kubectl"
    kubectl completion zsh > "$ZSHINE_CACHE_DIR/completion/_kubectl"
    compinit
fi

k() {
    if [[ "$#" -eq 0 ]]; then
        echo "Context: $(kubectl config current-context)"
        echo
        kubectl --request-timeout=2 get nodes
        echo
        kubectl --request-timeout=2 get all
    else
        kubectl "$@"
    fi
}
compdef k=kubectl  # use same completion

alias kl="kubectl logs"
alias kexe="kubectl exec -it"
alias kexp="kubectl explain"
alias kg="kubectl get"
alias ks="kubectl get -o yaml"
alias kev="kubectl events"

alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"
alias kc="kubectl config use-context"

kns() {
    local ns=$1

    printf '%s\n' "$1" > ~/.namespace
    kubectl_namespace=$ns
    alias kn="kubectl --namespace $ns"

    echo "namespace for \`kn\` set to '$ns'"
}

kubectl_namespace=$(< ~/.namespace)
alias kn="kubectl --namespace $kubectl_namespace"


# lazy-load completions

if [[ $commands[helm] ]]; then
    helm() {
        type _helm >/dev/null 2>&1 || source <(command helm completion zsh)
        command helm "$@"
    }
fi

if [[ $commands[kubectl] ]]; then
    kubectl() {
        type _kubectl >/dev/null 2>&1 || source <(command kubectl completion zsh)
        command kubectl "$@"
    }
fi
