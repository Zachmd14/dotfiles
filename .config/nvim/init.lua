-- set cusor lines
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.api.nvim_command("highlight CursorLine guibg=#2D313B")
vim.api.nvim_command("highlight CursorColumn guibg=#2D313B")
-- set show line number
vim.wo.number = true
-- Enable relative line numbers
vim.wo.relativenumber = true

-- Set conceallevel to 1
vim.o.conceallevel = 1

-- set keymaps for navigating
vim.api.nvim_set_keymap('n', 'j', 'h', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'l', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', 'm', 'l', { noremap = true })

vim.api.nvim_set_keymap('v', 'j', 'h', { noremap = true })
vim.api.nvim_set_keymap('v', 'k', 'j', { noremap = true })
vim.api.nvim_set_keymap('v', 'l', 'k', { noremap = true })
vim.api.nvim_set_keymap('v', 'm', 'l', { noremap = true })

local opts = { noremap = true, silent = true }
-- Press Shift + Ctrl + l to move to the window above
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd k<CR>', opts)
-- Press Shift + Ctrl + j to move to the window to the left
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd h<CR>', opts)
-- Press Shift + Ctrl + k to move to the window below
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd j<CR>', opts)
-- Press Shift + Ctrl + m to move to the window to the right
vim.api.nvim_set_keymap('n', '<C-m>', ':wincmd l<CR>', opts)
-- Prevent 's' from entering insert mode
vim.api.nvim_set_keymap('n', 's', '<NOP>', opts)
-- Create a new vertical split with 'sn' in normal mode
vim.api.nvim_set_keymap('n', 'sn', ':vsplit<CR>', opts)
-- Create a new horizontal split with 'sN' in normal mode
vim.api.nvim_set_keymap('n', 'sN', ':split<CR>', opts)
-- Resize window right
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize +5<CR>', opts)
-- Resize window left
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize -5<CR>', opts)
-- Resize window down
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -5<CR>', opts)
-- Resize window up
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +5<CR>', opts)

-- Set keymap for going into the current directory
vim.api.nvim_set_keymap('n', '<Space>n', ':cd $PWD<CR>', opts)

-- Press Ctrl + Suppr and Ctrl + Backspace for deleting entire word in insert mode
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-W>', opts)
vim.api.nvim_set_keymap('i', '<C-Del>', '<C-O>dw', opts)

vim.api.nvim_set_keymap('n', '<Space>b', ':Dashboard<CR>', opts)

-- set tab indent
vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Map `d` to delete without copying to any register
vim.api.nvim_set_keymap('n', 'd', '"_d', opts)
vim.api.nvim_set_keymap('n', 'dd', '"_dd', opts)
vim.api.nvim_set_keymap('v', 'd', '"_d', opts)

-- Map `c` to change without copying to any register
vim.api.nvim_set_keymap('n', 'c', '"_c', opts)
vim.api.nvim_set_keymap('n', 'cc', '"_cc', opts)
vim.api.nvim_set_keymap('v', 'c', '"_c', opts)

-- Map '<leader>t to the todo plugin'
-- vim.api.nvim_set_keymap('n', '<Space>t', ':Todo<CR>', opts)

-- Keymaps for Spectre
vim.api.nvim_set_keymap('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>',
	{ noremap = true, silent = true, desc = "Toggle Spectre" })
vim.api.nvim_set_keymap('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
	{ noremap = true, silent = true, desc = "Search current word" })
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',
	{ noremap = true, silent = true, desc = "Search current selection" })
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
	{ noremap = true, silent = true, desc = "Search in current file" })

-- Map '<leader>t to the timer plugin'
vim.api.nvim_set_keymap('n', '<Space>t', ':TimerlyToggle<CR>', opts)

-- set clipboard
vim.o.clipboard = 'unnamedplus'

-- set leader key
vim.api.nvim_set_var('mapleader', ' ')

-- enable vimtex default keymapping
vim.g.vimtex_mappings_enabled = 1

-- markdown folding

vim.opt.compatible = false
if vim.fn.has("autocmd") then
	vim.cmd("filetype plugin indent on")
end

-- Create an autocommand for Markdown file type
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.wo.foldexpr = "NestedMarkdownFolds()"
	end,
})

-- enable true colors
vim.opt.termguicolors = true
-- Load the plugins
require("zach.lazy")
