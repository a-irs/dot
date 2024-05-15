[[ $commands[kubectl] ]] || return

for f in ~/.kube/config*; do
    export KUBECONFIG="$f:$KUBECONFIG"
done
unset f

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
