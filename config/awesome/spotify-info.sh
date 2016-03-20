#!/usr/bin/env bash

set -e

out=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata')

title=$(echo "$out" | grep -A 1 xesam:title | tail -1 | cut -d\" -f 2)
title=${title//&/&amp;}
artist=$(echo "$out" | grep -A 2 xesam:artist | tail -1 | cut -d\" -f 2)
artist=${artist//&/&amp;}

if [[ "$title" && "$artist" ]]; then
    echo " <span foreground='#ffffff'>♫ <b>$title</b> ($artist)</span> "
fi

