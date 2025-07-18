#!/usr/bin/env zsh

http-echo() {
    local port=${1:-8080}
    docker run --rm -it -p "$port:$port" traefik/whoami -verbose -port "$port"
}

alias reload-aliases="source $0"

export BAT_THEME=ansi

v() {
    local before=$PWD
    cd "$1"
    local dest="$(command vifm --choose-dir -)"
    if [[ -n "$dest" ]] && [[ "$before" != "$dest" ]]; then
        # unset and re-set "auto-ls" chpwd hook
        local chpwd_before=$(which chpwd); chpwd() {}
        cd "$dest"
        eval $chpwd_before
    fi
}

_url() {
    local func=$1; shift
    local args=$@
    if (( $# >= 1 )); then
        python3 -c "import urllib.parse, sys; sys.stdout.writelines($func for line in sys.argv[1:])" "$@"
    else
        python3 -c "import urllib.parse, sys; sys.stdout.writelines($func for line in sys.stdin)"
    fi
}

_color_dig() {
    local esc=$(printf '\033')
    grep -vE \
        '(^;; Got answer|^;; flags:|^;; MSG SIZE|^;; WHEN|^;; OPT PSEUDO|^; EDNS:)' \
    | awk \
        '
        !/^;/    { print "\033[0m"$0 }
        /^;[^;]/ { print "\033[1;35m"$0 }
        /^;;/    { print "\033[1;30m"$0 }
        END      { print "\033[0m" }
        ' \
    | sed -E "s/(NXDOMAIN)/$esc\[31m\1$esc\[0m$esc\[1;30m/g"
}

dig() {
    local result=$(command dig +short "$@")

    # empty or error result
    if [[ -z "$result" ]]; then
        local dig_output=$(command dig +noall +comments +identify +question "$@")
        local err=$(printf "%s" "$dig_output" | grep -E '^;;.*status:' | sed -E 's/.*status: ([^,]+).*/\1/g')
        local comments=$(printf "%s" "$dig_output" | grep -E '^;; Received')
        local question=$(printf "%s" "$dig_output" | grep -A1 -E '^;; QUESTION' | tail -1)
        { echo "$question"; echo "$comments"; echo; echo "$err"; } | _color_dig
        return
    fi

    local dig_full=$(command dig +noall +identify +question +answer "$@")
    local dig_content=$(echo "$dig_full" | grep -vE '^;')
    local dig_comment=$(echo "$dig_full" | grep -E '^;')
    { echo "$dig_comment"; echo; echo "$dig_content" | column -t; } | _color_dig
}

digt() {
    command dig +trace +nodnssec "$@" | _color_dig
}

calc() {
    [[ "$#" == 0 ]] && local args="-i"
    python3 -B $args -c "from math import *; from statistics import *; print($*)"
}
alias calc="noglob calc"

json2yaml() {
    ruby -ryaml -e 'puts(YAML.load(ARGF.read).to_yaml(:indentation => 2, :line_width => 9999))'
}

yaml2json() {
    ruby -ryaml -rjson -e 'puts(YAML.load(ARGF.read).to_json)'
}

urle() { _url 'urllib.parse.quote(line)' "$@"; }
urld() { _url 'urllib.parse.unquote(line)' "$@"; }
urlep() { _url 'urllib.parse.quote_plus(line)' "$@"; }
urldp() { _url 'urllib.parse.unquote_plus(line)' "$@"; }

alias diff="diff --color=auto"
alias ip='ip -color=auto'

sshfp() {
    local output=$(ssh-keyscan "$@" 2>&1)
    local rc=$?
    if [[ "$rc" == 0 ]]; then
        echo "$output" | ssh-keygen -l -f /dev/stdin
    else
        echo "$output"
    fi
}

clip() {
    if [[ "$commands[xclip]" ]]; then
        if [[ -n "$1" ]]; then
            xclip -r -selection clipboard < "$1"
        elif [[ -t 0 ]]; then
            xclip -o -selection clipboard
        else
            xclip -r -selection clipboard
        fi
    elif [[ "$commands[pbcopy]" ]]; then
        if [[ -n "$1" ]]; then
            pbcopy < "$1"
        elif [[ -t 0 ]]; then
            pbpaste
        else
            pbcopy
        fi
    fi
}

[[ "$commands[aria2c]" ]] && alias aria2c="aria2c --file-allocation=none --continue true --check-integrity true --max-connection-per-server=8 --disk-cache=512M"

if [[ "$commands[nvim]" ]]; then
    alias vim='nvim'
    vim=nvim
else
    vim=vim
fi
alias vi="$vim -N -u <(cat $HOME/.vim/conf.d/00_basic.vim $HOME/.vim/conf.d/99_post.vim)"

anon() {
    unset HISTFILE
    if [[ -n "$ZSHINE_PROMPT_SYMBOL" ]]; then
        ZSHINE_PROMPT_SYMBOL="ANON $ZSHINE_PROMPT_SYMBOL"
    else
        PS1="${PS1}ANON >"
    fi
    alias vim="$vim -n -i NONE '+set undolevels=-1'"
    add-zsh-hook -d chpwd chpwd_recent_dirs
    add-zsh-hook -d preexec _fasd_preexec
    zstyle ':chpwd:*' recent-dirs-file /dev/null +
    export LESSHISTFILE=/dev/null
 }

alias et="emacsclient -c --alternate-editor='' -t"
alias e="emacsclient -c --alternate-editor='' -n"

hex() { xxd "$1" | $vim +'set ft=xxd' -; }

# open e.g. html file in temporary browser in app mode
web() {
    local t f
    f=$1
    t=$(mktemp -d)

    bash -c "/usr/bin/chromium --user-data-dir=\"$t\" --app=\"file://\$(readlink -f \"$f\")\" &> /dev/null; rm -rf \"$t\"" &
}

if [[ "$commands[docker]" ]]; then
    alias do-r="docker run --rm -it"
    do-rp() { docker run --rm -it -v "$PWD:/work" -w /work "$@"; }
    alias do-rm="docker run --rm -it"
    alias do-ps="docker ps"
    alias do-i="docker images"
    do-rm() { docker rm "$@" || docker rmi "$@"; }
fi

mac() { curl -q "https://api.macvendors.com/${1:0:8}" && printf "\n"; }

cht() {
    local query=${(j:+:)@}  # join all argument strings with "+" (URL whitespace)
    if [[ -n "$query" ]]; then
        curl -s "https://cht.sh/$query?style=rrt" | less -FXR
    else
        curl -s "https://cht.sh/:random?style=rrt" | less -FXR
    fi
}

tar-tar() { tar cvaf "$(basename "$PWD")".tar -- "$@"; }
tar-gz()  { tar cvaf "$(basename "$PWD")".tar.gz -- "$@"; }
tar-xz()  { tar cvaf "$(basename "$PWD")".tar.xz -- "$@"; }
tar-bz()  { tar cvaf "$(basename "$PWD")".tar.bz2 -- "$@"; }
tar-lz()  { tar cvaf "$(basename "$PWD")".tar.lzma -- "$@"; }
tar-zip() { zip -r "$(basename "$PWD")".zip -- "$@"; }

rotate-log() {
    [[ -z "$1" || ! -f "$1" ]] && return 1
    local outname="$1_$(date +'%F_%H-%M-%S')"
    mv -v "$1" "$outname" && zstd --rm "$outname"
}

toggle-scheme() {
    # Termite
    if [[ $(readlink ~/.config/termite/config) == config_light ]]; then
        (cd ~/.config/termite && ln -sfv config_dark config)
    elif [[ $(readlink ~/.config/termite/config) == config_dark ]]; then
        (cd ~/.config/termite && ln -sfv config_light config)
    else
        (cd ~/.config/termite && ln -sfv config_dark config)
    fi
    killall -USR1 termite 2> /dev/null

    # VIM
    if grep -q 'set background=dark' ~/.vimrc; then
        sed --follow-symlinks -i 's/set background=dark/set background=light/g' ~/.vimrc
        echo "sed dark -> light"
    elif grep -q 'set background=light' ~/.vimrc; then
        sed --follow-symlinks -i 's/set background=light/set background=dark/g' ~/.vimrc
        echo "sed light -> dark"
    fi
}

each-file() {
    for f in *(.); do
        echo -e "\n${BOLD_YELLOW}$* ${f}${RESET}\n"
        eval "$@" "$f"
    done
}

back() {
    nohup "$@" </dev/null &>/dev/null &
}

monitor() {
    while true; do
        clear
        printf '%s%s\n' "$GREEN" "$*"
        printf '%s%*s%s' "$GREEN" "$(tput cols)" "$(date +%H:%M:%S)" "$RESET"
        eval "$@"
        sleep 0.5
    done
}

wait_until_process_not_exists() {
    while pgrep -x "$1" > /dev/null; do
        sleep 0.5
    done
    echo "$1 does not exist any more"
}

wait_until_file_does_not_exist() {
    while [[ -e "$1" ]]; do
        sleep 0.1
    done
    echo "$1 does not exist any more"
}

dl-calc() {
    case "$1" in
        (*T|*t|*Tb|*TB|*tb|*tB) UNIT1=TB ;;
        (*G|*g|*Gb|*GB|*gb|*gB) UNIT1=GB ;;
        (*M|*m|*Mb|*MB|*mb|*mB) UNIT1=MB ;;
        (*K|*k|*Kb|*KB|*kb|*kB) UNIT1=KB ;;
        (*) echo "unknown" && return 1;;
    esac
    local VAL1=${1//,/\.}
    VAL1=${VAL1//[^0-9|\.]}

    case "$2" in
        (*T|*t|*Tb|*TB|*tb|*tB) UNIT2=TB ;;
        (*G|*g|*Gb|*GB|*gb|*gB) UNIT2=GB ;;
        (*M|*m|*Mb|*MB|*mb|*mB) UNIT2=MB ;;
        (*K|*k|*Kb|*KB|*kb|*kB) UNIT2=KB ;;
        (*) echo "unknown" && return 1;;
    esac
    local VAL2=${2//,/\.}
    VAL2=${VAL2//[^0-9|\.]}

    case "$UNIT1" in
        KB) VAL1B=$((VAL1*1024)) ;;
        MB) VAL1B=$((VAL1*1024*1024)) ;;
        GB) VAL1B=$((VAL1*1024*1024*1024)) ;;
        TB) VAL1B=$((VAL1*1024*1024*1024*1024)) ;;
    esac

    case "$UNIT2" in
        KB) VAL2B=$((VAL2*1024)) ;;
        MB) VAL2B=$((VAL2*1024*1024)) ;;
        GB) VAL2B=$((VAL2*1024*1024*1024)) ;;
        TB) VAL2B=$((VAL2*1024*1024*1024*1024)) ;;
    esac

    echo -ne "\nDownloading ${BOLD_GREEN}$VAL2 $UNIT2${RESET} at ${BOLD_GREEN}$VAL1 $UNIT1/s${RESET} takes ${BLUE}"

    local TIME=$((VAL2B/VAL1B))
    local DAYS=$(( TIME / 60 / 60 / 24 ))
    local HOURS=$(( TIME / 60 / 60 % 24 ))
    local MINUTES=$(( TIME / 60 % 60 ))
    local SECONDS=$(( TIME % 60 ))
    (( DAYS > 0 )) && echo -n "${DAYS}d and "
    (( HOURS > 0 )) && echo -n "${HOURS}h "
    (( MINUTES > 0 )) && echo -n "${MINUTES}m "
    (( SECONDS > 0 )) && echo -n "${SECONDS}s"
    (( SECONDS == 0 )) && echo -n "less than 1s."
    echo "${RESET}"
}

p() { for f in "$@"; do printf "\n%s\n\n" "=========== $f" && s "$f"; done }

[[ "$commands[less]" ]] && alias less='less -FXR'
[[ "$commands[lsblk]" ]] && alias lsblk='lsblk -o NAME,LABEL,TYPE,FSTYPE,SIZE,MOUNTPOINT,UUID -p'
[[ "$commands[grep]" ]] && alias grep='grep --color=auto'
[[ "$commands[dmesg]" ]] && alias dmesg='dmesg -T --color=auto'
[[ "$commands[sudo]" ]] && alias sudo='sudo '
[[ "$commands[pydf]" ]] && alias df='pydf'

if [[ "$commands[fd]" || "$commands[fdfind]" ]]; then
    fd=fd
    [[ "$commands[fdfind]" ]] && fd=fdfind

    fd="$fd --hidden --no-ignore --no-ignore-vcs"

    alias fd="$fd"
    alias fdf="$fd --type f"
    alias fdd="$fd --type d"
    alias fda="$fd --hidden --no-ignore --unrestricted --no-ignore-vcs"
fi
[[ "$commands[rg]" ]] && alias rg='rg --case-sensitive'
alias rga='rg -uuu'

alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
take() { mkdir -p "$1" && cd "$1"; }
alias rd='rmdir'
alias f='noglob find . -name'
alias chx='chmod u+x'

alias mmv='noglob zmv -W'

if [[ "$commands[iotop]" ]]; then
    iotop() {
        sudo sysctl kernel.task_delayacct=1
        sudo iotop -o
        sudo sysctl kernel.task_delayacct=0
    }
fi

# define basic "ls" first
if [[ "$commands[lsd]" ]]; then
    ls="\lsd -F --date relative --group-dirs first"
elif [[ "$commands[gls]" ]]; then
    ls="\gls -F --literal --color=auto --group-directories-first"
else
    if [[ "$os" == darwin* ]]; then
        ls="\ls -F"
        alias lo="\ls -lhGF -O@"
    else
        ls="\ls -F --literal --color=auto --group-directories-first"
    fi
fi

# ls aliases
alias l="$ls"
alias ls="$ls -lh"
alias ll="$ls -lh"
alias la="$ls -lhA"
alias lss="$ls -lhSr"
alias l.="$ls -lhd .*"
alias lt="$ls -lhtr"
alias lS="$ls -lhSr"

[[ "$commands[python]" ]] && alias http-share='python -m http.server'
[[ "$commands[dropbox-cli]" ]] && alias ds='dropbox-cli status'
[[ "$commands[dropbox-cli]" ]] && alias dstop='dropbox-cli stop'
[[ "$commands[dropbox-cli]" ]] && alias dstart='dropbox-cli start'

if [[ "$commands[nmcli]" ]]; then
    alias nd='nmcli connection down'
    nu() {
        if [[ -n "$1" ]]; then
            nmcli connection up "$1"
        else
            local last_connected=$(nmcli --wait 1 --terse --colors no --fields name,timestamp,type,active connection show | grep ':no$' | grep 'wireless:' | sort --field-separator=: -k 2 | tail -1 | cut -d: -f 1)
            echo "Switching to '$last_connected'"
            nmcli connection up "$last_connected"
        fi
    }
fi

if [[ "$commands[tmux]" ]]; then
    # capture tmux pane and edit in vim
    tmux-capture() {
        # http://man7.org/linux/man-pages/man1/tmux.1.html
        tmux capture-pane -pCJS - \
            | sed -E -e 's/[[:space:]]*$//' \
            | sed -E -e 's/.*\s*$/-------------------------/' \
            | $vim -
    }
fi

[[ "$commands[xev]" ]] && capture-keys() { xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'; }
if [[ "$commands[yt-dlp]" ]]; then
    alias yt="noglob yt-dlp -f 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --write-sub --sub-lang en,de --embed-subs --write-info-json --sponsorblock-remove default --embed-metadata --embed-chapters"
    alias yt-audio="noglob yt-dlp -f 'bestaudio[ext=m4a]' --sponsorblock-remove default --embed-metadata --embed-chapters --extract-audio"
fi
[[ "$commands[journalctl]" ]] && alias j='sudo journalctl'

[[ "$commands[ncdu]" ]] && alias ncdu='NO_COLOR=1 ncdu'

if [[ "$commands[xdg-open]" ]]; then
    os() {
        [[ -z "$1" || ! -e "$1" ]] && return 1
        mimeopen --ask-default "$1"
    }
    o() {
        if [[ ! "$1" ]]; then
            echo xdg-open .
            nohup xdg-open . </dev/null &>/dev/null & disown
        else
            for x in "$@"; do
                echo xdg-open "$x"
                nohup xdg-open "$x" </dev/null &>/dev/null & disown
            done
            unset x
        fi
    }
fi
[[ "$commands[open]" ]] && alias o=open

cd() {
    if [[ -f "$1" ]]; then
        printf "${YELLOW}%s${RESET}\n\n" "cd: correcting $1 to ${1:h}"
        builtin cd "${1:h}"
    else
        builtin cd "$@"
    fi
}

[[ -d ~/.dot ]] && dot() { cd ~/.dot; git status -sb; }
[[ -d ~/git/a-irs/dot ]] && dot() { cd ~/git/a-irs/dot; git status -sb; }
[[ -d ~/infra ]] && infra() { cd ~/infra; git status -sb; }

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

alias x=extract

highlight()       {
    grep --color -E "$1|$"
}

highlight_files() {
    grep --color -E "$1|$" "${@:2}"
}

if [[ "$commands[git]" ]]; then
    alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white) %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
    alias glp="git log -p"
    alias gc="git c"
    alias gca="git ca"
    alias gp="git push"
    alias gs="git s"
    alias gd="git d"
    alias ge="git ls-files -m --others --exclude-standard -z :/ | command fzf --multi --preview='s {}' --exit-0 --read0 --print0 --height=70% --reverse --select-1 | xargs -0 -o $vim"

    gop() {
        local arg=$1
        local remote_url=$(git config remote.origin.url)
        if [[ "$?" -ne 0 || "$remote_url" == "" ]]; then
            echo "fatal: not a git repository (or any of the parent directories): .git"
            return
        fi

        local branch=$(git rev-parse --abbrev-ref HEAD)
        [[ -n "$arg" ]] && local file=$(git rev-parse --show-prefix "$arg" | tr '\n' '/')
        local url=https://$(
            echo "$remote_url" \
            `# remove protocol://, username@ etc.` \
            | perl -pe 's|^(.*://\|.*@)||' \
            `# replace : with / inside` \
            | perl -pe 's|:|/|' \
            `# remove .git` \
            | perl -pe 's|\.git$||'
        )/tree/$branch/$file

        printf '%s\n' "opening: $url"
        if [[ "$os" == darwin* ]]; then
            open "$url"
        else
            xdg-open "$url"
        fi
    }
fi

psg() {
    [[ ! "$1" ]] && ps auxww && return
    local process="$*";
    ps auxww | grep -i \[${process:0:1}\]${process:1:${#process}-1}
}

if [[ "$commands[pacman]" ]]; then
    toggle-testing() {
        if [[ -e /etc/pacman.d/conf.d/testing.conf ]]; then
            sudo rm /etc/pacman.d/conf.d/testing.conf
            echo -e "${YELLOW}! disabled testing repos${RESET}"
        else
            echo '[core-testing]
Include = /etc/pacman.d/mirrorlist

[extra-testing]
Include = /etc/pacman.d/mirrorlist
' | sudo tee /etc/pacman.d/conf.d/testing.conf
            if [[ -e /etc/pacman.d/conf.d/multilib.conf ]]; then
            echo '[multilib-testing]
Include = /etc/pacman.d/mirrorlist'
            fi | sudo tee -a /etc/pacman.d/conf.d/testing.conf
            sudo chmod 0644 /etc/pacman.d/conf.d/testing.conf
            echo -e "\n${RED}! enabled testing repos${RESET}\n"
            sudo pacman -Sy
            echo ""
            LC_ALL=C pacman -Sl core-testing extra-testing multilib-testing | cut -d " " -f 2- | grep "\[installed" | awk 'function r(s){return "\033[1;31m" s "\033[0m"}function y(s){return "\033[1;33m" s "\033[0m"}{gsub("]","",$4); printf("%-35s %s -> %s\n", y($1), $4, r($2))}'
        fi
    }
    alias pi='sudo pacman -S'
    alias pid='sudo pacman -S --asdeps'
    alias pr='sudo pacman -Rns'
    alias prc='sudo pacman -Rnsc'
    alias pss='pacman -Ss'
    alias psi='pacman -Si'
    alias pqi='pacman -Qi'
    alias pqk='sudo pacman -Qk > /dev/null'
    pqo() {
        echo ":: pacman local"
        pacman -Qo "$1"
        echo ""
        echo ":: pkgfile"
        pkgfile -v -s "$1"
    }
    pql() { pacman -Qlq "$1" | xargs ls --color -dlh || pkgfile -l "$1"; }
    pqlb() { pacman -Qlq "$1" | xargs ls -dlh | grep '/bin/' | grep -Ev '/usr/bin/$' || pkgfile -l "$1" -b; }
    alias pu='sudo pacman -U'
    alias pacorph='sudo pacman -Rns $(pacman -Qttdq)'
    alias pacdiff="sudo DIFFPROG=\"$EDITOR -d\" pacdiff"
    alias pacdep='sudo pacman -D --asdeps'
    alias pacexp='sudo pacman -D --asexplicit'
    if [[ "$commands[yay]" ]]; then
        if [[ $USER == root ]]; then
            alias yay="sudo -u makepkg yay"
        fi
    fi
elif [[ "$commands[apt-get]" ]]; then
    alias aptupg="sudo apt-get update && sudo apt-get -V dist-upgrade"
    alias aptin="sudo apt-get -V install"
    alias aptrem="sudo apt-get -V purge"
    alias aptauto="sudo apt-get -V autoremove --purge"
    alias aptsearch="apt-cache search"
fi

fonttest() {
    for family in "serif" "sans" "sans-serif" "monospace" "Arial" "Helvetica" "Verdana" "Times New Roman" "Courier New"; do
        echo -n "$family | "
        fc-match "$family"
    done | column -t -s '|' | column -t -s ':'
    echo ""
    echo "🥯 🦆 🦉 🥓 🦄 🦀 🖕 🍣 🍤 🍥 🍡 🥃 🥞 🤯 🤪 🤬 🤮 🤫 🤭 🧐 🐕 🦖"
}

man() {
    MANWIDTH=999 vim -c "SuperMan $*"
}

[[ "$commands[xrandr]" ]] && xr-scale() {
    # get settings from xrandr
    xrandr=$(LC_ALL=C xrandr)
    local -i x_default=$(echo ${xrandr} | grep "\*" | column -t | cut -d " " -f 1 | cut -d "x" -f 1)
    local -i y_default=$(echo ${xrandr} | grep "\*" | column -t | cut -d " " -f 1 | cut -d "x" -f 2)
    local output=$(echo ${xrandr} | grep " connected" | cut -d " " -f 1)
    unset -v xrandr

    # set to default if no func argument is given
    if [[ -z "$1" ]]; then
        echo "usage: xr <width>"
        echo "setting default display size"
        xrandr --output "${output}" --mode "${x_default}x${y_default}" --panning "${x_default}x${y_default}" --scale 1x1
        return
    fi

    # set safe constraints for the display
    safe_bottom=$((x_default/2))
    safe_top=$((x_default*3))
    if [[ "$1" -lt $safe_bottom || "$1" -gt $safe_top ]]; then
        echo "$1 is not in safe display range between $safe_bottom and $safe_top"
        return
    fi

    # calculate new sizes
    local ratio=$(LC_ALL=C printf "%.2f" $(($x_default.0/y_default)))
    local -i x="$1"
    local -i y=$((x/ratio))
    local scale=$((${x}.0/x_default))

    # change panning
    echo "output: ${output}"
    echo "size: ${x}x${y}"
    echo "scale: ${scale}"
    xrandr --output "${output}" --mode "${x_default}x${y_default}" --panning "${x}x${y}" --scale "${scale}x${scale}"
}

russian-roulette() {
    echo -n "spinning "
    s=$(( $RANDOM.0 / 75000 ))
    num=$(( RANDOM % 8 + 2 ))

    for (( c = 0; c <= num; c++ )); do
        echo -n "."
        sleep $s
    done

    if (( RANDOM % 6 == 0)); then
        echo '\033[1;31m BOOM'
    else
        echo '\033[2m click'
    fi
}

separator() {
    BAR="="
    FILL="\${(l.${COLUMNS}..${BAR}.)}"
    printf "\n\033[33m${(e)FILL}\033[0m\n\n"
}

spectrum_ls() {
    for code in {000..255}; do
        print -P -- "$code: %F{$code}Arma virumque cano Troiae qui primus ab oris%f"
    done
}

spectrum_bls() {
    for code in {000..255}; do
        print -P -- "%{\e[48;5;${code}m%}$code: Arma virumque cano Troiae qui primus ab oris %{$reset_color%}"
    done
}

colortest() {
    echo
    echo -en "\e[0;39mDefault\e[0m   "
    echo -e "\e[1;39mDefault Bold\e[0m"
    echo -en "\e[0;30mBlack\e[0m     "
    echo -e "\e[1;30mBlack Bold\e[0m"
    echo -en "\e[0;31mRed\e[0m       "
    echo -e "\e[1;31mRed Bold\e[0m"
    echo -en "\e[0;32mGreen\e[0m     "
    echo -e "\e[1;32mGreen Bold\e[0m"
    echo -en "\e[0;33mYellow\e[0m    "
    echo -e "\e[1;33mYellow Bold\e[0m"
    echo -en "\e[0;34mBlue\e[0m      "
    echo -e "\e[1;34mBlue Bold\e[0m"
    echo -en "\e[0;35mMagenta\e[0m   "
    echo -e "\e[1;35mMagenta Bold\e[0m"
    echo -en "\e[0;36mCyan\e[0m      "
    echo -e "\e[1;36mCyan Bold\e[0m"
    echo -en "\e[0;37mGrey\e[0m      "
    echo -e "\e[1;37mGrey Bold\e[0m"
}

if [[ "$commands[systemctl]" ]]; then
    user_commands=(
        list-units is-active status show help list-unit-files is-enabled
        list-jobs show-environment suspend suspend-then-hibernate hibernate
        cat
    )
    sudo_commands=(
        start stop reload restart try-restart isolate kill daemon-reload
        reset-failed enable disable reenable preset mask unmask
        link load cancel set-environment unset-environment
    )
    for c in $user_commands; do; alias sc-$c="systemctl $c"; done
    for c in $sudo_commands; do; alias sc-$c="sudo systemctl $c"; done

    for c in $user_commands; do; alias scu-$c="systemctl --user $c"; done
    for c in $sudo_commands; do; alias scu-$c="systemctl --user $c"; done
    alias lock="loginctl lock-session"
fi
unset sudo_commands user_commands

nfo() {
    iconv -f cp437 -t utf8 "$@" | less -Q
}

pall() {
    printf "\n"
    local git_dirs=(
        ~/.dot
        ~/.doc
        ~/infra
    )
    for d in "${git_dirs[@]}"; do
        if [[ -d "$d" ]]; then
            printf "${BLUE}%s${RESET}\n" "${d//$HOME/~}"
            git -C "$d" status -sbu
            git -C "$d" pull
            printf "\n"
        fi
    done
}

sandbox() {
    [[ -z "$1" ]] && return
    program=$1
    mkdir -p "$HOME/tmp/sandbox/$program"
    firejail \
        --private="$HOME/tmp/sandbox/$program" --noprofile \
        --private-dev --private-tmp --caps.drop=all --disable-mnt --net=wlan0 --net=eth0 --protocol=unix,inet,inet6 \
        "$@"
}

sandbox-light() {
    [[ -z "$1" ]] && return
    program=$1
    mkdir -p "$HOME/tmp/sandbox/$program"
    firejail \
        --private="$HOME/tmp/sandbox/$program" --noprofile \
        "$@"
}

cdt() {
    builtin cd "$(mktemp -d -t cdt.XXX)"
}

alias i2png="mogrify -format png"

# text-to-speech from stdin
[[ "$commands[spd-say]" ]] && alias say="spd-say --pipe-mode --wait"

alias curlj="curl -H 'Content-Type: application/json'"
