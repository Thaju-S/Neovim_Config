vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

------------------------------------------------------------

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

------------------------------------------------------------

vim.lsp.enable('lua_ls')

------------------------------------------------------------

local function bootstrap_pckr()
    local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

    if not (vim.uv or vim.loop).fs_stat(pckr_path) then
	vim.fn.system({
	    'git',
	    'clone',
	    "--filter=blob:none",
	    'https://github.com/lewis6991/pckr.nvim',
	    pckr_path
	})
    end

    vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

------------------------------------------------------------

require('pckr').add
{
    'tpope/vim-fugitive',
    'neovim/nvim-lspconfig',
    {
	'nvim-telescope/telescope.nvim', version = '*',
	requires = {
	    { 'nvim-lua/plenary.nvim' },
	    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
	    local builtin = require('telescope.builtin')
	    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end,
    },

    {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function()
	    local configs = require('nvim-treesitter')
	    configs.setup({
		highlight = { enable = true },
		indent = { enable = true },
		autotags = { enable = true },
		ensure_installed = {
		    'lua',
		    'python',
		    'java',
		    'c',
		    'cpp',
		},
		autoinstall = true,
	    })
	end
    }
}
