local opts = { noremap = true, silent = true }

-- Toggle comment on current line or visual selection
vim.api.nvim_set_keymap('n', 'gcc', '<Plug>Commentary', opts)
vim.api.nvim_set_keymap('x', 'gcc', '<Plug>Commentary', opts)
