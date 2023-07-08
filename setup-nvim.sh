#!/bin/bash

echo Checking Dependencies...
sudo pacman -Sy neovim git npm --needed

# echo Installing packer.nvim
# git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.config/nvim/site/pack/packer/start/packer.nvim
