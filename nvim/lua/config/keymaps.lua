-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opt = vim.opt
local keymap = vim.keymap
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>mm", ":MaximizerToggle<CR>")
