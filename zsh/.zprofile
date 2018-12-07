# to make touchscreen scrolling work with firefox
export MOZ_USE_XINPUT2=1

[[ "$TTY" != /dev/tty* ]] && return

# start redshift in oneshot DRM mode (works in tty)
[[ "$commands[redshift]" ]] && redshift -o -m drm

if [[ -n "$commands[startx]" ]]; then
    [[ -z "$DISPLAY" && "$XDG_VTNR" == 1 && "$USER" != root ]] && startx
fi
