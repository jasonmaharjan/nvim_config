local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup({
    defaults = {
        layout_strategy = "horizontal", -- Can be "horizontal", "vertical", "center", or "cursor"
        layout_config = {
            width = 0.99,               -- % of the editor width
            preview_width = 0.5,        -- % of the total width for preview
        },
    },
})
