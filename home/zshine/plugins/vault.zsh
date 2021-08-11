#!/usr/bin/env bash

export VAULT_ADDR="https://vault.$(grep '^domain' /etc/resolv.conf | cut -d ' ' -f 2)"

v-login() {
    vault login --method=oidc role=default
}

v-sshkey() {
    rm -f ~/.ssh/vault
    ssh-keygen -C '' -t ed25519 -f ~/.ssh/vault -N ''

    vault write \
        -field=signed_key \
        ssh-client/sign/ssh \
        public_key=@$HOME/.ssh/vault.pub \
        valid_principals=root,$USER \
        > ~/.ssh/vault-cert.pub

    if [[ "$?" -eq 0 ]]; then
        ssh-keygen -Lf ~/.ssh/vault-cert.pub
    fi
}

v-token() {
    vault token lookup
    echo
    local id=$(vault token lookup | grep '^entity_id' | awk '{print $2}')
    vault read "identity/entity/id/$id"
}
