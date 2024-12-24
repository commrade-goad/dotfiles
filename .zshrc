# Enable auto-completion
autoload -Uz compinit
compinit

# Load Bash completion scripts
autoload -Uz bashcompinit
bashcompinit

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Enable menu selection for completions
zstyle ':completion:*' menu select

# Enable approximate matches (e.g., fix typos)
zstyle ':completion:*' completer _complete _approximate

# Prompt setup

# [user@computer path]$ 
# PROMPT='%F{red}[%F{blue}%n%F{none}@%m %~%F{red}]%F{blue}$%F{none} '

#  path > 
# PROMPT='%F{blue} %~%F{green} %B>%b %F{none}'

# [ path ] \n >
NEWLINE=$'\n'
PROMPT="%B┌[%F{cyan}%b%n%f%B@%b%F{blue}%m%B%f]%b-%B[%F{cyan}%b%(3~|../%2~|%3~)%B%f]%b${NEWLINE}└> "

# change red if not return 0
precmd() {
  if [[ $? -eq 0 ]]; then
    PROMPT="%B┌[%F{cyan}%b%n%f%B@%b%F{blue}%m%B%f]%b-%B[%F{cyan}%b%(3~|../%2~|%3~)%B%f]%b${NEWLINE}└> "
  else
    PROMPT="%B%F{red}┌%f[%F{cyan}%b%n%f%B@%b%F{blue}%m%B%f]%b%F{red}-%f%B[%F{cyan}%b%(3~|../%2~|%3~)%B%f]%b${NEWLINE}%F{red}└>%f "
  fi
}

# plugin stuff
source ~/.local/share/zsh-plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/share/zsh-plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh-plugin/zsh-history-substring-search/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""

# binding stuff
# Ctrl+r backward search
bindkey '^[[H' beginning-of-line # Home key
bindkey '^[[F' end-of-line       # End key
bindkey '^[[3~' delete-char      # Delete key
bindkey '^[[Z' undo              # Shift+Tab

# Enable word movement with Ctrl + Left/Right Arrow
bindkey "^[[1;5C" forward-word   # Ctrl + Right Arrow
bindkey "^[[1;5D" backward-word  # Ctrl + Left Arrow

# Alternate codes for some terminal emulators
bindkey "^[[5C" forward-word
bindkey "^[[5D" backward-word

# substring search
bindkey '^[[A' history-substring-search-up   # Up arrow to search backward
bindkey '^[[B' history-substring-search-down # Down arrow to search forward

# Zoxide
eval "$(zoxide init zsh)"

# Yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# export and startup
# ~/Documents/Programming/shell/reimoo.sh
source ~/Documents/Programming/shell/default.sh
export EDITOR="nvim"
export PATH="$PATH:/home/fernando/.local/bin"
# export MANPAGER='nvim +Man!'

# Alias setup
alias sudo='doas'
alias ls="eza -l --all --icons --header --git --group-directories-first --sort=date"
alias clean-orphan="sudo pacman -Qtdq | sudo pacman -Rns -"
alias clean-orphan-all="sudo pacman -Qttdq | sudo pacman -Rns -"
alias yt-dl="python3 '/home/fernando/git/goad-yt-dlp-helper/src/yt-dlp-helper-v2-5.py'"
alias weather="curl wttr.in"
alias calendar="cal -3"
alias v="nvim"
# alias sv="sudoedit"
alias sv="doas nvim"
alias vn-wine="WINEPREFIX='/home/fernando/.local/share/wineprefixes/VisNov/' wine"
alias sy-wine="WINEPREFIX=/home/fernando/.local/share/wineprefixes/sybase wine"
alias jplocale="LC_ALL=ja_JP.UTF8"
alias jplocale-shift="LC_ALL=ja_JP.sjis"
alias touhou-playlist="mpv 'https://www.youtube.com/playlist?list=PLXZnhQ4xFkPXkPd0aiW3V12UMBFD38tXg' --no-video"
alias convert-sjis="~/Documents/Programming/shell/convert-sjis.sh"
alias img2ascii-py="python3 /home/fernando/Documents/Programming/Python/linux/ascii-project/ascii-v2-unix.py"
alias :wq="exit"
alias open="frun xdg-open"
alias user-mount="udisksctl"
alias vkeybind="nvim ~/.config/nvim/lua/keys.lua"
alias neofetch="fastfetch"
alias reload-waybar="pkill waybar && hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/alternative/style.css -c ~/.config/hypr/waybar/alternative/config.jsonc"
alias m-build="meson build && cp ./build/compile_commands.json ./"
alias tarx="tar -xvzf"
alias grep="grep --color=always"
alias ip="ip --color=always"
alias tm="tmux a || tmux"

# alias sch-zoom="firefox 'https://us02web.zoom.us/my/kelasxismakstagnes?pwd=b0lYRVpyemx2QlJZR0E4ci96Wnd0dz09'"
# alias sch-zoom="xdg-open 'https://us06web.zoom.us/j/87416985509?pwd=Rkk5UElPenVKMXVFNFNxZzFJckpGQT09'"
# alias osis-disc="echo 'https://discord.gg/qTg84cHDR4'"
# alias jpv="LC_ALL=ja_JP.sjis nvim"
# alias jpv="LC_ALL=ja_JP.UTF8 nvim"
# alias cp="rsync -ah --info=progress2"
