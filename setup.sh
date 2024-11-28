#!/usr/bin/env sh

CONFIG_PATH="$HOME/.config/"
LOCAL_PATH="$HOME/.local/share"
mkdir -p $CONFIG_PATH
mkdir -p $LOCAL_PATH

inst_nvim() {
    mv $LOCAL_PATH/nvim $LOCAL_PATH/nvim.bak
    mv $CONFIG_PATH/nvim $CONFIG_PATH/nvim.bak
    cp -r ./nvim  $CONFIG_PATH
    echo -e "neovim config installed"
}

inst_zsh() {
    cp -r ./zsh/zsh-plugin $LOCAL_PATH
    mv $HOME/.zshrc $HOME/.zshrc.bak
    cp ./zsh/.zshrc $HOME
    echo -e "zsh config installed"
}

inst_more_script() {
    mkdir -p $HOME/Documents/Programming/shell/
    cp ./more-scripts/* $HOME/Documents/Programming/shell/
    echo -e "more-scripts installed"
}

inst_all() {
    inst_nvim
    inst_zsh
    inst_more_script
    cp -r ./assets/ $LOCAL_PATH
    cp -r ./alacritty $CONFIG_PATH 
    cp -r ./dunst $CONFIG_PATH 
    cp -r ./foot $CONFIG_PATH 
    cp -r ./hypr $CONFIG_PATH 
    cp -r ./rofi $CONFIG_PATH 
    cp -r ./sway $CONFIG_PATH 
    cp -r ./waybar $CONFIG_PATH 
    cp ./cusprus.toml $CONFIG_PATH
    cp ./cusprus-hypr.toml $CONFIG_PATH
    echo -e "installed all the config."
}

# install all (uncomment line below)
# inst_all

# install nvim config only (uncomment line below)
# inst_nvim

# install zsh config only (uncomment line below)
# inst_zsh

# install optional more-scripts only (uncomment line below)
# inst_more_script

echo -e " -=[!]=- Dont forget to install the needed package with your distro package manager. -=[!]=-\n"
