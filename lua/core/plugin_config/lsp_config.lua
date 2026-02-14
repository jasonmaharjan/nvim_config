-- ========================
-- LSP Setup for Neovim 0.11+
-- ========================

-- CMP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- On attach keymaps
local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

-- ========================
-- Mason Setup
-- ========================
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()
mason_lsp.setup({})

-- Auto-setup installed Mason LSP servers
local installed_servers = mason_lsp.get_installed_servers()
for _, server_name in ipairs(installed_servers) do
    if lspconfig[server_name] then
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
end

-- ========================
-- Manual servers
-- ========================

-- Typescript
if lspconfig.ts_ls then
    lspconfig.ts_ls.setup({
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        capabilities = capabilities,
    })
end

-- Lua LS
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

if lspconfig.lua_ls then
    lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT", path = runtime_path },
                diagnostics = { globals = { "vim", "use" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    })
end

-- JSON LS
if lspconfig.jsonls then
    lspconfig.jsonls.setup({
        on_attach = on_attach,
        cmd = { "vscode-json-languageserver", "--stdio" },
        filetypes = { "json" },
        capabilities = capabilities,
        settings = {
            json = {
                format = { enable = false },
                validate = { enable = true },
            },
        },
    })
end

-- ESLint
if lspconfig.eslint then
    lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            on_attach(client, bufnr)
        end,
    })
end

-- CSS LS
if lspconfig.cssls then
    lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- PyLSP
if lspconfig.pylsp then
    lspconfig.pylsp.setup({
        on_attach = on_attach,
        filetypes = { "python" },
        capabilities = capabilities,
        settings = {
            configurationSources = { "flake8" },
            formatCommand = { "black" },
            pylsp = {
                plugins = {
                    pyflakes = { enabled = true },
                    pylsp_mypy = { enabled = false },
                    pycodestyle = {
                        enabled = true,
                        ignore = { "E501", "E231", "W291", "E302", "E305" },
                        maxLineLength = 120,
                    },
                    yapf = { enabled = true },
                },
            },
        },
    })
end

-- ========================
-- Prettier Setup
-- ========================
local ok, prettier = pcall(require, "prettier")
if ok then
    prettier.setup({
        ["null-ls"] = {
            on_attach = on_attach,
            condition = function()
                return prettier.config_exists({ check_package_json = true })
            end,
            runtime_condition = function() return true end,
            timeout = 5000,
        },
        bin = "prettier",
        filetypes = {
            "css", "graphql", "html", "javascript", "javascriptreact",
            "json", "less", "markdown", "scss", "typescript",
            "typescriptreact", "yaml",
        },
        cli_options = {
            arrow_parens = "avoid",
            print_width = 80,
            semi = true,
            tab_width = 4,
            trailing_comma = "es5",
            use_tabs = false,
        },
        autoprettier = true,
    })
end
