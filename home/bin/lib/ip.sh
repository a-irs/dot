#!/usr/bin/env bash

set -e

if [[ $1 == ip ]]; then
    curl -f -sS https://ipinfo.io/ip
    exit
fi

# IP info
out=$(curl -f -sS https://ipinfo.io/)
jsn <<< "$out" | grep -v 'readme'

# PTR
ip=$(jq -r .ip <<< "$out")
dig +short -x "$ip"
