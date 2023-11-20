vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- lazy.nvim plugin manager
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

require('lazy').setup({
	--{ 
		--'AlexvZyl/nordic.nvim',
		--lazy = false,
		--priority = 1000,
		--config = function()
			--require 'nordic' .load()
		--end
	--}
	{
		'rebelot/kanagawa.nvim',
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = 'papercolor_dark',
			},
		},
	},
}, {})

-- Set line number
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Set Scrolloff
vim.o.scrolloff = 7

-- Sync clipborad between OS and Neovim
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Tab Config
-- Set tab size
vim.o.tabstop = 4
-- Set autoindent tab size
vim.o.shiftwidth = 4

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

