vim.g.barbar_auto_setup = false -- Disable auto-setup (if default config isn't desired)

require 'barbar'.setup {
    -- animation = true,
    -- auto_hide = false,                                        -- Hide bar when only one buffer is open
    -- icons = {
    --     buffer_index = true,                                  -- Disable buffer index
    --     buffer_number = false,                                -- Disable buffer number
    --     button = '',                                          -- No close button
    --     filetype = { enabled = false },                       -- Disable filetype icons
    --     separator = { left = '', right = '' },                -- Remove separators
    --     inactive = { separator = { left = '', right = '' } }, -- Inactive tab separators
    -- },
    maximum_padding = 2,
    maximum_length = 30,
    semantic_letters = true,
    gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
    },
    no_name_title = 'Untitled Buffer',
    -- options = {
    --     name_formatter = function(buf)
    --         -- Get the relative path of the file
    --         local relative_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":~:.")

    --         -- Log the relative path to a file for debugging
    --         local log_file = vim.fn.stdpath('cache') .. '/barbar_relative_paths.log'
    --         local log_message = string.format("Buffer %d: %s\n", buf, relative_path)

    --         -- Append the log message to the log file
    --         local log_handle = io.open(log_file, "a")
    --         if log_handle then
    --             log_handle:write(log_message)
    --             log_handle:close()
    --         else
    --             print("Failed to open log file: " .. log_file)
    --         end

    --         return relative_path
    --     end,
    -- },
}
-- Buffer Key Remappings
vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-x>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
