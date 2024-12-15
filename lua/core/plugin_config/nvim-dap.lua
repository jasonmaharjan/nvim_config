-- require('dapui').setup()

-- -- Debugger keymappings
-- vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })

-- -- add configurations for debugging javascript
-- local dap = require("dap")

-- dap.adapters.node2 = {
--     type = 'executable',
--     command = 'node',
--     args = { '--inspect-brk', '${file}' },
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--     skipFiles = { '<node_internals>/**/*.js' },
-- }

-- dap.configurations.javascript = {
--     {
--         type = 'node2',
--         request = 'launch',
--         program = '${file}',
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = 'inspector',
--         console = 'integratedTerminal',
--         skipFiles = { '<node_internals>/**/*.js' },
--     }
-- }
