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

--- Essentials
vim.g.mapleader = " "

--- Plugins
require("lazy").setup('user.plugins', {
	change_detection = {
		-- check for config file changes and get a notification
		enabled = true,
		notify = true,
	},
})

-- Enable fzf for Telescope
require('telescope').load_extension('fzf')

--- Custom configuration
require('user.settings')		-- My sane defaults
require('user.mappings')		-- Custom keymappings
