#!/usr/bin/env bash

set -e

send_backup() {
    [ "$(ls -A /tmp/offsite-backup/$1)" ] || exit 1
    rsync -axz --delete --numeric-ids -e 'ssh -p 5522' "/tmp/offsite-backup/$1" alex@zshine.net:backups
}

send_backup dell
send_backup desktop
