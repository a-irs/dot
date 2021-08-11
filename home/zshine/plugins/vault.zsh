#!/usr/bin/env bash

export VAULT_ADDR="https://vault.$(grep -E '^(domain|search)\s' /etc/resolv.conf | cut -d ' ' -f 2)"

v-login() {
    vault login --method=oidc
}

_v-sshkey() {
    local vault_path=$1
    local principals=$2

    rm -f ~/.ssh/vault
    ssh-keygen -C '' -t ed25519 -f ~/.ssh/vault -N ''

    vault write \
        -field=signed_key \
        "$vault_path" \
        public_key=@$HOME/.ssh/vault.pub \
        valid_principals="$principals" \
        > ~/.ssh/vault-cert.pub

    if [[ "$?" -eq 0 ]]; then
        ssh-keygen -Lf ~/.ssh/vault-cert.pub
    fi
}

v-sshkey-user() {
    _v-sshkey ssh-client/sign/ssh-user $USER
}

v-sshkey-admin() {
    _v-sshkey ssh-client/sign/ssh-admin root,$USER
}

v-token() {
    vault token lookup
    echo
    local id=$(vault token lookup | grep '^entity_id' | awk '{print $2}')
    vault read "identity/entity/id/$id"
}

v-ssh() {
    command ssh -F /dev/null -i ~/.ssh/vault "$@"
}
