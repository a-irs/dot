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
alias ky="kubectl get -o yaml"
alias ksecret="kubectl get secret --template='{{range \$k,\$v := .data}}{{\$k}} = {{\$v|base64decode}}{{\"\n\"}}{{end}}'"
alias kev="kubectl events"

kdebug() {
    local selection=$(kubectl get pod -A | fzf --reverse)
    local ns="$(awk '{print $1}' <<< $selection)"
    local pod="$(awk '{print $2}' <<< $selection)"
    local cmd="kubectl debug --image digitalocean/doks-debug:latest --image-pull-policy=IfNotPresent -it -n $ns $pod"
    echo ":: $cmd"
    eval $cmd
}

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

kubectl_namespace=$(< ~/.namespace) 2>/dev/null
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
