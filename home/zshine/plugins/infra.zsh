load() {
    for d in ~/infra; do
        [[ -O "$d" ]] && PATH="$d/ansible/bin:$d/docker/bin:$d/container-shot/bin:$PATH"
    done
}

load
unfunction load
