-- Define key mappings for Git Fugitive
vim.keymap.set('n', '<Leader>gs', ':Git<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>ga', ':Git add .<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gd', ':Git diff<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gp', ':Git push<CR>', { noremap = true, silent = true })
