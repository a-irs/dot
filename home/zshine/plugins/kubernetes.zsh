if [[ $commands[kubectl] ]]; then
    source <(kubectl completion zsh)  # TODO: cache this!
    k() {
        if [[ "$#" -eq 0 ]]; then
            echo "Context: $(kubectl config current-context)"
            echo
            kubectl get nodes
            echo
            kubectl get all
        else
            kubectl "$@"
        fi
    }
fi

if [[ $commands[helm] ]]; then
    source <(helm completion zsh)
fi

# for f in /etc/rancher/k3s/k3s.yaml ~/.kube/config; do
for f in ~/.kube/config*; do
    export KUBECONFIG="$f:$KUBECONFIG"
done
unset f
