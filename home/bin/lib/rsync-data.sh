#!/usr/bin/env bash
# backup data from srv1:/media/data and backup:/mnt/data/crypt.enc to USB disk

set -e

MOUNT=/media/usb-backup
TARGET=/media/usb-backup/hosts/srv1
TARGET2=/media/usb-backup/hosts/backup

control_c() {
  set +e
  echo -en "\n*** CTRL+C - starting cleanup ***\n"
  sync
  umount -lf "$MOUNT"
  sync
  exit $?
}
trap control_c SIGINT

BACKUP=(
	/media/data/photos
	/media/data/photos_google
	/media/data/photos_print
	/media/data/videos/kids
	/media/data/crypto.enc
	/media/data/apps
	/media/data/books
	/media/data/games
	/media/data/music
	/media/data/switch
)

delay=0.3

if ! mount "$MOUNT"; then
	echo -e '\a' > /dev/console ; sleep $delay
	echo -e '\a' > /dev/console ; sleep $delay
	echo -e '\a' > /dev/console
	echo -e '\a' > /dev/console
    exit 1
fi

for d in "${BACKUP[@]}"; do
    if [[ ! -d "$d" ]]; then
        echo "ERROR: $d does not exist."
        exit 1
    fi
    date=$(date +%Y-%m-%d)_$(date +%H-%M-%S)
    dir=$(basename "$d")
    rsync $* -av -h --delete --stats \
        --delay-updates --delete-after \
        --log-file="$TARGET/$dir.log" \
        --backup --backup-dir="$TARGET/0-archive/$dir/$date/" \
        "$d" \
        "$TARGET"
done

date=$(date +%Y-%m-%d)_$(date +%H-%M-%S)
rsync $* -av -h --delete --stats \
    --delay-updates --delete-after \
    --log-file="$TARGET2/borg.log" \
    --backup --backup-dir="$TARGET2/0-archive/borg/$date/" \
    root@backup:/mnt/data/crypt.enc \
    "$TARGET2"

sync
umount -lf "$MOUNT"
sleep 5s
sync
echo -e '\a' > /dev/console ; sleep $delay
echo -e '\a' > /dev/console
