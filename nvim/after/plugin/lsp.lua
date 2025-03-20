vim.opt.signcolumn = 'yes'

-- Floating window borders
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- Errors & Warnings
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        style  = 'minimal',
        border = 'rounded',
        header = '',
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN]  = '▲',
            [vim.diagnostic.severity.HINT]  = '⚑',
            [vim.diagnostic.severity.INFO]  = '»',
        },
    },
})

-- Add cmp_nvim_lsp capabilities settings to lspconfig
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = ev.buf }

        -- gotos
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        -- goto diagnostics
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', 'gnl', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', 'gpl', vim.diagnostic.goto_prev, opts)

        -- docs
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        -- code actions
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<F3>', vim.lsp.buf.format({ async = true }))
    end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        -- Activate default handler for every language server without a custom handler.
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup({
                cmd = { 'rust-analyzer' },
                completion = { autoimport = { exclude = {
                    { path = 'std::usize', type = "always" },
                    { path = 'std::isize', type = "always" },
                }}},
            })
        end,

        pylsp = function()
            require('lspconfig').pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {enabled = false},
                            pyflakes = {enabled = false},
                        },
                    },
                },
            })
        end,

        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                },
            })
        end,

        hls = function()
            require('lspconfig')['hls'].setup{
                filetypes = { 'haskell', 'lhaskell', 'cabal' },
            }
        end,

        --sourcekit = function()
        --    require('lspconfig').sourcekit.setup {
        --        cmd = {'/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp'}
        --    }
        --end,

        --omnisharp = function()
        --    require('lspconfig').omnisharp.setup({
        --        handlers = {
        --            ["textDocument/definition"] = require('omnisharp_extended').handler,
        --        }
        --    })
        --end,
    },
})

local cmp = require("cmp")
require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu, menuone,noinsert'
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = function(entry, item)
            local n = entry.source.name
            if n == 'nvim_lsp' then
                item.menu = '[LSP]'
            else
                item.menu = string.format('[%s]', n)
            end
            return item
        end,
    },
    mapping = {
        -- Confirm comletion item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Scroll docs window
        ['<C-f>'] = cmp.mapping.scroll_docs(5),
        ['<C-u>'] = cmp.mapping.scroll_docs(-5),

        -- Toggle completion menu
        ['<C-e>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.abort()
            else
                cmp.complete()
            end
        end),

        -- Tab complete
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.')-1
            if cmp.visible() then
                cmp.select_next_item({ behavior = 'select' })
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        -- Previous item
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),

        -- Next snippet placeholder
        ['<C-d>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),

        ['<C-b>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),

        ['<C-Space>'] = cmp.mapping.complete(),
    },
})

