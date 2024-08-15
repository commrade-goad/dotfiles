# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cg"

##USER
#neofetch --ascii_distro arch_small --disable title underline model shell resolution wm term icons cpu gpu cols
export EDITOR='nvim'
# /home/fernando/Documents/Programming/shell/reimoo.sh
/home/fernando/Documents/Programming/shell/default.sh
PATH="$PATH:/home/fernando/.local/bin"

# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
 zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias ls="eza -l --all --icons --header --git --group-directories-first"
alias restart-plasma="kquitapp5 plasmashell && kstart5 plasmashell"
alias clean-orphan="sudo pacman -Qtdq | sudo pacman -Rns -"
alias clean-orphan-all="sudo pacman -Qttdq | sudo pacman -Rns -"
alias yt-dl="python3 '/home/fernando/git/goad-yt-dlp-helper/src/yt-dlp-helper-v2-5.py'"
alias weather="curl wttr.in"
alias calendar="cal -3"
alias v="nvim"
alias sv="sudoedit"
alias vn-wine="WINEPREFIX='/home/fernando/.local/share/wineprefixes/VisNov/' wine"
alias sy-wine="WINEPREFIX=/home/fernando/.local/share/wineprefixes/sybase wine"
alias jplocale="LC_ALL=ja_JP.UTF8"
alias jplocale-shift="LC_ALL=ja_JP.sjis"
alias touhou-playlist="mpv 'https://www.youtube.com/playlist?list=PLXZnhQ4xFkPXkPd0aiW3V12UMBFD38tXg' --no-video"
alias convert-sjis="~/Documents/Programming/shell/convert-sjis.sh"
alias img2ascii-py="python3 /home/fernando/Documents/Programming/Python/linux/ascii-project/ascii-v2-unix.py"
alias :wq="exit"
alias update="yay -Syu"
alias binom-calc="~/git/rust-binom-calc/target/release/rust-binom-calc"
alias open="frun xdg-open"
alias user-mount="udisksctl"
alias vkeybind="nvim ~/.config/nvim/lua/keys.lua"
alias neofetch="fastfetch"
alias reload-waybar="pkill waybar && hyprctl dispatch -- exec waybar -s ~/.config/hypr/waybar/alternative/style.css -c ~/.config/hypr/waybar/alternative/config.jsonc"
alias m-build="meson build && cp ./build/compile_commands.json ./"
alias login-sql="mysql -u root -p -S /opt/lampp/var/mysql/mysql.sock"
alias cat="bat"
alias rm="trash"
eval "$(zoxide init zsh)"
# alias restart-plasma-f="kquitapp5 plasmashell || killall plasmashell && kstart5 plasmashell"
# alias sch-zoom="firefox 'https://us02web.zoom.us/my/kelasxismakstagnes?pwd=b0lYRVpyemx2QlJZR0E4ci96Wnd0dz09'"
# alias sch-zoom="xdg-open 'https://us06web.zoom.us/j/87416985509?pwd=Rkk5UElPenVKMXVFNFNxZzFJckpGQT09'"
# alias osis-disc="echo 'https://discord.gg/qTg84cHDR4'"
# alias osu="echo 'lib32-libxcomposite lib32-gnutls(lib32-gmp lib32-nettle lib32-gnutls)' && gamemoderun wine '/home/fernando/.wine/drive_c/users/fernando/AppData/Local/osu!/osu!.exe'"
# alias fate="wine '/media/Fate stay night Realta Nua/game/Fate.exe'"
# alias nbfc-stat="mono /opt/nbfc/nbfc.exe status --all"
# alias nbfc="mono /opt/nbfc/nbfc.exe"
# alias baloo-kill="killall baloo_file; killall /usr/lib/baloorunner; killall /usr/bin/baloo_file_extractor"
# alias jpv="LC_ALL=ja_JP.sjis nvim"
# alias jpv="LC_ALL=ja_JP.UTF8 nvim"
# alias img2ascii="broke for now"
# alias color-correct="swaymsg exec \"wl-gammactl -c 0.935 -b 0.998 -g 0.806\""
# alias compile-hypr="~/Documents/Programming/shell/recompile-hypr.sh"
# alias echo="printf"
# alias cp="rsync -ah --info=progress2"
