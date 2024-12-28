-- LAZY PACKAGE MANAGER
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plug") -- plugin

-- CONFIG
require("keys") -- keybind
require("opts") -- options
require("lspconf") -- lsp configuration
require("plugconf") -- plugin configuration
require("welcome") -- alpha dashboard configuration
require("none") -- lint + format
require("snip") -- user defined snippet
