local opts = { noremap = true, silent = true }

-- Window resizing (no default keybinding)
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Buffer/File management
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", opts)  -- Toggle NvimTree
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)  -- Save file
vim.keymap.set('n', '<C-q>', ':q<CR>', opts)  -- Quit Neovim
vim.keymap.set('n', '<C-w>q', ':wq<CR>', opts)  -- Save and quit Neovim

-- Indentation in visual mode (useful)
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep cursor centered after search
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
