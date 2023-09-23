require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (first five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "go", "rust", "markdown", "markdown_inline", "python"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  context_commentstring = {
        enable = true,
    },

  incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the --[[ mappings ]]
            node_incremental = ".",
            scope_incremental = ";",
            node_decremental = ",",
        },
    },

  indent = {
        enable = true,
    },

  autotag = {
        enable = true,
    },
}
