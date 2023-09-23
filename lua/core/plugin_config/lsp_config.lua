require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "cssls", "biome" },
}

-- require("lspconfig").sumneko_lua.setup {}
