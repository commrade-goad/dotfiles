## export and startup
# ~/Documents/Programming/shell/reimoo.sh
# source ~/Documents/Programming/shell/default.sh
export EDITOR="nvim"
export PATH="$PATH:/home/fernando/.local/bin"
export PYTHON_HISTORY="$HOME/.cache/py_hist"
# export MANPAGER='nvim +Man!'

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
PROMPT="%B┌[%F{cyan}%b%n%f%B@%b%F{blue}%m%B%f]%b-%B[%F{cyan}%b%(3~|../%2~|%3~)%B%f]%b${NEWLINE}└> "

precmd() {
  if [[ $? -eq 0 ]]; then
    PROMPT="%B┌[%F{green}%b%n%f%B@%b%F{blue}%m%B%f]%b-%B[%F{cyan}%b%(3~|../%2~|%3~)%B%f]%b${NEWLINE}└> "
  else
    PROMPT="%B%F{red}┌%f[%F{green}%b%n%f%B@%b%F{blue}%m%B%f]%b%F{red}-%f%B[%F{cyan}%b%(3~|../%2~|%3~)%B%f]%b${NEWLINE}%F{red}└>%f "
  fi
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

## emacs mode
## ^f -> accept suggestion or forward
## ^p or ^n next or prev the history
## ^b backward from the prompt
## ^a start of the prompt
## ^e end of the prompt
# bindkey -e
bindkey -v

## Zoxide
eval "$(zoxide init zsh)"

## fzf
eval "$(fzf --zsh)"

## Yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

## Alias setup
alias ls="eza -l --all --icons --header --git --group-directories-first --sort=date"
alias clean-orphan="sudo pacman -Qtdq | sudo pacman -Rns -"
alias clean-orphan-all="sudo pacman -Qttdq | sudo pacman -Rns -"
alias yt-dl="python3 '$HOME/git/goad-yt-dlp-helper/src/yt-dlp-helper-v2-5.py'"
alias weather="curl wttr.in"
alias calendar="cal -3"
alias v="nvim"
alias sv="sudoedit"
alias vn-wine="WINEPREFIX='$HOME/.local/share/wineprefixes/VisNov/' wine"
alias sy-wine="WINEPREFIX=$HOME/share/wineprefixes/sybase wine"
alias jplocale="LC_ALL=ja_JP.UTF8"
alias jplocale-shift="LC_ALL=ja_JP.sjis"
alias touhou-playlist="mpv 'https://www.youtube.com/playlist?list=PLXZnhQ4xFkPXkPd0aiW3V12UMBFD38tXg' --no-video"
alias convert-sjis="~/Documents/Programming/shell/convert-sjis.sh"
alias img2ascii-py="python3 $HOME/Documents/Programming/Python/linux/ascii-project/ascii-v2-unix.py"
alias :wq="exit"
alias open="frun xdg-open"
alias user-mount="udisksctl"
alias vkeybind="nvim ~/.config/nvim/lua/keys.lua"
alias neofetch="fastfetch"
alias reload-waybar="pkill waybar && hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/style.css -c ~/.config/hypr/waybar/config.jsonc"
alias m-build="meson build && cp ./build/compile_commands.json ./"
alias tarx="tar -xvzf"
alias grep="grep --color=always"
alias ip="ip --color=always"
alias tm="tmux a || tmux"
alias crm="command rm"
alias rm="trash"
