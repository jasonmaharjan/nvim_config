local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim-autopairs' },
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            max_height = 15,
            max_width = 60,
        }
    },
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = function(entry, item)
            local short_name = {
                nvim_lsp = 'LSP',
                nvim_lua = 'nvim'
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
        end,
    },
    completion = {
        completeopt = 'menu, menuone, noselect',
    }
})

-- If you want insert `(` after select function or method item
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
