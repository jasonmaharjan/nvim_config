local mason = require("mason")
local mason_configs = require("mason-lspconfig")

local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local on_attach = function(_,_)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

mason.setup()
mason_configs.setup({})

local get_servers = mason_configs.get_installed_servers

for _, server_name in ipairs(get_servers()) do
    lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

local servers = { "tsserver" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "use" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

local prettier = require("prettier")
prettier.setup({
    ["null-ls"] = {
        on_attach = on_attach,
        condition = function()
            return prettier.config_exists({
                check_package_json = true,
            })
        end,
        runtime_condition = function()
            return true
        end,
        timeout = 5000,
    },
    bin = "prettier",
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
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

lspconfig.jsonls.setup({
    cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { "json" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
    settings = {
        json = {
            format = {
                enable = false,
            },
            validate = { enable = true },
        },
    },
})

lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        on_attach(_, bufnr)
    end,
})

lspconfig.cssls.setup({
    on_attach = on_attach,
})

-- require("typescript").setup({
-- 	disable_commands = false, -- prevent the plugin from creating Vim commands
-- 	debug = false, -- enable debug logging for commands
-- 	go_to_source_definition = {
-- 		fallback = true, -- fall back to standard LSP definition on failure
-- 	},
-- 	server = { -- pass options to lspconfig's setup method
-- 		on_attach = function(...)
-- 			on_attach(...)
-- 		end,
-- 	},
-- })

-- require("lspconfig").lua_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--           [vim.fn.stdpath "config" .. "/lua"] = true,
--         },
--       },
--     },
--   }
-- }

