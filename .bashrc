# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend

PROMPT_COMMAND='history -a; history -n'
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%F %T "

export EDITOR="nvim"
export VISUAL="nvim"
export PYTHON_HISTORY="$HOME/.cache/py_hist"
export GOPATH="$HOME/.cache/go"
export GNUPGHOME="$HOME/.local/share/gnupg"
export npm_config_cache="$HOME/.cache/npm"
export CARGO_HOME="$HOME/.cache/cargo"
export RUSTUP_HOME="$HOME/.local/opt/rustup"
export MANPAGER='nvim +Man!'
export ACCENT_COLOR="A7C080"
export PROMPT_DIRTRIM=2
export QT_QPA_PLATFORMTHEME=qt6ct

PATH="$PATH:$HOME/.local/share/bin"

set "completion-ignore-case on"

have()
{
    unset -v have
    _have $1 && have=yes
}

_custom_sway()
{
    export XCURSOR_SIZE=24
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export QT_QPA_PLATFORMTHEME=qt6ct
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    # WLR_RENDERER=vulkan dbus-run-session sway
    dbus-run-session sway
    if [ -z $XDG_SESSION_ID ]; then
        return
    fi

    loginctl kill-session $XDG_SESSION_ID
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

eval "$(zoxide init bash)"
eval "$(fzf --bash)"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

## Alias setup
alias sway="_custom_sway"
alias ls="ls -lASh --color=auto --group-directories-first"
alias yt-dl="python3 '$HOME/Documents/dev/goad-yt-dlp-helper/src/yt-dlp-helper-v2-5.py'"
alias weather="curl wttr.in"
alias calendar="cal -3"
alias v="nvim"
alias touhou-playlist="mpv 'https://www.youtube.com/playlist?list=PLXZnhQ4xFkPXkPd0aiW3V12UMBFD38tXg' --no-video"
alias :wq="exit"
alias reload-waybar="pkill waybar && hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/style.css -c ~/.config/hypr/waybar/config.jsonc"
alias tarx="tar -xvzf"
alias grep="grep --color=always"
alias tm="tmux a || tmux"
alias rm="rm -I"
alias rsync="rsync -ah --info=progress2"
alias reloadmime="update-desktop-database ~/.local/share/applications/"
alias sudo="doas"

PS1='\[\e[91;1m\][\[\e[0;93m\]\u\[\e[92;1m\]@\[\e[0;94m\]\h\[\e[0m\] \[\e[95m\]\w\[\e[91;1m\]]\[\e[0m\]\$ '
