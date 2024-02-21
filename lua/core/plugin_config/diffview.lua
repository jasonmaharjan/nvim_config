_G.diffview_enabled = false

_G.toggle_diffview = function()
    if _G.diffview_enabled then
        vim.cmd(':DiffviewClose')
    else
        vim.cmd(':DiffviewOpen')
    end
    _G.diffview_enabled = not _G.diffview_enabled
end

-- Map a key to the toggle_diffview function
vim.api.nvim_set_keymap('n', '<Leader>gf', '<Cmd>lua toggle_diffview()<CR>', { noremap = true, silent = true })
