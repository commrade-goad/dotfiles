## export and startup
NEWPATH="$HOME/.local/bin":$PATH
export PATH=$NEWPATH
export EDITOR="nvim"
export PYTHON_HISTORY="$HOME/.cache/py_hist"
export GOPATH="$HOME/.cache/go"
export GNUPGHOME="$HOME/.local/share/gnupg"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc"
export npm_config_cache="$HOME/.cache/npm"
export CARGO_HOME="$HOME/.cache/cargo"
export RUSTUP_HOME="$HOME/.local/opt/rustup"
export MANPAGER='nvim +Man!'

export ACCENT_COLOR=$(cat $HOME/.local/share/assets/swieng/custom-color-ref | grep 'accent' | awk -F ' ' '{print $3}' | sed 's/"//g')

## zsh hooks
autoload -Uz add-zsh-hook

## Enable auto-completion
autoload -Uz compinit
compinit -d "$HOME/.cache/zcompdump"

## Load Bash completion scripts
autoload -Uz bashcompinit
bashcompinit

## History configuration
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
HISDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

## Enable case-insensitive completion and ls suggestion color
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

## Enable menu selection for completions
zstyle ':completion:*' menu select

## Enable approximate matches (e.g., fix typos)
zstyle ':completion:*' completer _complete _approximate

## Prompt setup
NEWLINE=$'\n'
BOLD_BEGIN="%B"
BOLD_END="%b"
RESET_COLOR="%f"

USERNAME_FORMAT="%n"
MACHINENAME_FORMAT="%m"
TRUNCATED_PATH="%(3~|../%2~|%3~)"

ERROR_COLOR="red"
MACHINE_COLOR="blue"
USER_COLOR="#$ACCENT_COLOR"
FG_COLOR="yellow"

function COLOR_PROMPT() {
    if [[ -n "$1" ]]; then
        echo "%F{$1}"
    else
        echo "%F{white}"
    fi
}

function check_foreground_process() {
    JOBCOUNT=$(jobs -p | wc -l)
    if [[ $JOBCOUNT -gt 0 ]]; then
        echo "$JOBCOUNT"
    else
        echo ""
    fi
}

function set_prompt() {
    local last_exit_status=$?

    if [[ $last_exit_status -eq 0 ]]; then
        TOP_FIRST="${BOLD_BEGIN}┌[$(COLOR_PROMPT $USER_COLOR)${BOLD_END}${USERNAME_FORMAT}${RESET_COLOR}${BOLD_BEGIN}@${BOLD_END}$(COLOR_PROMPT $MACHINE_COLOR)${MACHINENAME_FORMAT}${BOLD_BEGIN}${RESET_COLOR}]${BOLD_END}"
        TOP_SECOND="-${BOLD_BEGIN}[$(COLOR_PROMPT $USER_COLOR)${BOLD_END}${TRUNCATED_PATH}${BOLD_BEGIN}${RESET_COLOR}]${BOLD_END}"
        BOTTOM_PROMPT="└> "
    else
        TOP_FIRST="$(COLOR_PROMPT $ERROR_COLOR)${BOLD_BEGIN}┌${RESET_COLOR}[$(COLOR_PROMPT $USER_COLOR)${BOLD_END}${USERNAME_FORMAT}${RESET_COLOR}${BOLD_BEGIN}@${BOLD_END}$(COLOR_PROMPT $MACHINE_COLOR)${MACHINENAME_FORMAT}${BOLD_BEGIN}${RESET_COLOR}]${BOLD_END}"
        TOP_SECOND="$(COLOR_PROMPT $ERROR_COLOR)-${RESET_COLOR}${BOLD_BEGIN}[$(COLOR_PROMPT $USER_COLOR)${BOLD_END}${TRUNCATED_PATH}${BOLD_BEGIN}${RESET_COLOR}]${BOLD_END}"
        BOTTOM_PROMPT="$(COLOR_PROMPT $ERROR_COLOR)└>${RESET_COLOR} "
    fi

    local foreground_status=$(check_foreground_process)
    if [[ -n "$foreground_status" ]]; then
        TOP_THIRD=" » $(COLOR_PROMPT yellow)${foreground_status}${RESET_COLOR}"
    else
        TOP_THIRD=""
    fi

    TOP_PROMPT="${TOP_FIRST}${TOP_SECOND}${TOP_THIRD}"
    PROMPT="${TOP_PROMPT}${NEWLINE}${BOTTOM_PROMPT}"
}

add-zsh-hook precmd set_prompt

# yazi stuff
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

## plugin stuff
source ~/.local/share/zsh-plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh-plugin/zsh-history-substring-search/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""

## Ctrl+r backward search
bindkey '^R' history-incremental-search-backward
bindkey '^[[H' beginning-of-line # Home key
bindkey '^[[F' end-of-line       # End key
bindkey '^[[3~' delete-char      # Delete key
bindkey '^[[Z' undo              # Shift+Tab

## Enable word movement with Ctrl + Left/Right Arrow
bindkey "^[[1;5C" forward-word   # Ctrl + Right Arrow
bindkey "^[[1;5D" backward-word  # Ctrl + Left Arrow

## Alternate codes for some terminal emulators
bindkey "^[[5C" forward-word
bindkey "^[[5D" backward-word

## substring search
bindkey '^[[A' history-substring-search-up   # Up arrow to search backward
bindkey '^[[B' history-substring-search-down # Down arrow to search forward

## vim keybind
bindkey -v

## Zoxide
eval "$(zoxide init zsh)"

## fzf
eval "$(fzf --zsh)"

## Check if its ssh
# if [[ -z "$SSH_CONNECTION" && -z "$SSH_TTY" && -z $TMUX ]]; then
#     tmux a || tmux
# fi

## Alias setup
alias ls="eza -l --all --icons --header --git --group-directories-first"
alias lsd="eza -l --all --icons --header --git --group-directories-first --sort=date"
alias clean-orphan="sudo pacman -Qtdq | sudo pacman -Rns -"
alias clean-orphan-all="sudo pacman -Qttdq | sudo pacman -Rns -"
alias yt-dl="python3 '$HOME/git/goad-yt-dlp-helper/src/yt-dlp-helper-v2-5.py'"
alias weather="curl wttr.in"
alias calendar="cal -3"
alias v="nvim"
alias sv="sudoedit"
alias vn-wine="WINEPREFIX='$HOME/.local/share/wineprefixes/VisNov/' wine"
alias sy-wine="WINEPREFIX=$HOME/.local/share/wineprefixes/sybase wine"
alias jplocale="LC_ALL=ja_JP.UTF8"
alias jplocale-shift="LC_ALL=ja_JP.sjis"
alias touhou-playlist="mpv 'https://www.youtube.com/playlist?list=PLXZnhQ4xFkPXkPd0aiW3V12UMBFD38tXg' --no-video"
alias convert-sjis="~/Documents/Programming/shell/convert-sjis.sh"
alias img2ascii-py="python3 $HOME/Documents/Programming/Python/linux/ascii-project/ascii-v2-unix.py"
alias :wq="exit"
alias user-mount="udisksctl"
alias vkeybind="nvim ~/.config/nvim/lua/keys.lua"
alias neofetch="fastfetch"
alias reload-waybar="pkill waybar && hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/style.css -c ~/.config/hypr/waybar/config.jsonc"
alias m-build="meson build && cp ./build/compile_commands.json ./"
alias tarx="tar -xvzf"
alias grep="grep --color=always"
alias ip="ip --color=always"
alias tm="tmux a || tmux"
alias rm="rm -I"
alias crm="trash"
alias rsync="rsync -ah --info=progress2"
alias reloadmime="update-desktop-database ~/.local/share/applications/"
