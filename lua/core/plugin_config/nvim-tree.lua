vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Git configuration
   local git_config = {
      enable = true,   -- Enable Git integration
      ignore = false,  -- Do not ignore Git files
      timeout = 500,   -- Set the timeout for Git operations (in milliseconds)
   }

-- Nvim Tree
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
  vim.g.nvim_tree_git_hl_files = 1
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('Previous Sibling'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 're', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'df', api.fs.remove, opts('Delete'))

  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'v', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'S', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', '[', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  git = git_config,
})
