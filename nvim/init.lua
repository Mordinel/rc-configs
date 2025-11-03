vim.opt.nu = true
vim.opt.guicursor = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.colorcolumn = "100"

vim.opt.mouse = ""

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.g.mapleader = ','
vim.g.maplocalleader = ';'

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.api.nvim_create_user_command('E',
function()
    vim.cmd('Explore')
end,
{})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            'Mordinel/vim-sunsurfer',
            lazy = false,
            priority = 1000,
            init = function()
                vim.cmd([[colorscheme sunsurfer]])
            end,
        },
        {
            'Mordinel/auto-dark-mode.nvim',
            dependencies = {'Mordinel/vim-sunsurfer'},
            opts = {
                set_dark_mode = function()
                    vim.api.nvim_set_option_value('background', 'dark', {})
                    vim.cmd([[colorscheme sunsurfer]])
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option_value('background', 'light', {})
                    vim.cmd([[colorscheme sunsurfer]])
                end,
            }
        },

        { 'tpope/vim-fugitive' },

        { 'nvim-treesitter/nvim-treesitter',
            branch = 'master',
            lazy = 'false',
            build = ':TSUpdate',
            opts = {
                -- A list of parser names, or "all" 
                ensure_installed = { "lua", "vim", "vimdoc", "rust" },
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = false,
                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            },
        },

        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lua',
                'saadparwaiz1/cmp_luasnip',
                'L3MON4D3/LuaSnip',
                'rafamadriz/friendly-snippets',
            },
            config = function()
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
            end,
        },

        {
            'mason-org/mason-lspconfig.nvim',
            lazy = false,
            opts = { },
            dependencies = {
                { 'mason-org/mason.nvim', opts = {} },
                {
                    'neovim/nvim-lspconfig',
                    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
                    opts = { },
                    config = function()
                        vim.lsp.config('rust_analyzer', {
                            completion = { autoimport = { exclude = {
                                { path = 'std::usize', type = "always" },
                                { path = 'std::isize', type = "always" },
                                { path = 'std::f32', type = "always" },
                                { path = 'std::f64', type = "always" },
                                { path = 'std::u64', type = "always" },
                                { path = 'std::i64', type = "always" },
                                { path = 'std::u32', type = "always" },
                                { path = 'std::i32', type = "always" },
                                { path = 'std::str', type = "always" },
                                { path = 'core::usize', type = "always" },
                                { path = 'core::isize', type = "always" },
                                { path = 'core::f32', type = "always" },
                                { path = 'core::f64', type = "always" },
                                { path = 'core::u64', type = "always" },
                                { path = 'core::i64', type = "always" },
                                { path = 'core::u32', type = "always" },
                                { path = 'core::i32', type = "always" },
                                { path = 'core::str', type = "always" },
                            }}},
                        })
                        vim.lsp.enable('rust_analyzer')

                        vim.lsp.config('pylsp', {
                            settings = {
                                pylsp = {
                                    plugins = {
                                        pycodestyle = { enabled = false },
                                        pyflakes = { enabled = false },
                                        -- autopep8 = { enabled = false },
                                        -- flake8 = { enabled = false },
                                        -- pylint = { enabled = false },
                                        -- yapf = { enabled = false },
                                    },
                                },
                            },
                        })
                        -- vim.lsp.enable('pylsp')

                        vim.lsp.config('basedpyright', {
                            settings = {
                                basedpyright = {
                                    analysis = {
                                        typeCheckingMode = 'standard',
                                    },
                                },
                            },
                        })
                        vim.lsp.enable('basedpyright')

                        vim.lsp.config('lua_ls', {
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
                        vim.lsp.enable('lua_ls')

                        -- vim.lsp.config('hls', {
                        --     filetypes = { 'haskell', 'lhaskell', 'cabal' },
                        -- })
                        -- vim.lsp.enable('hls')

                        -- vim.lsp.config('sourcekit', {
                        --     cmd = {'/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp'}
                        -- })
                        -- vim.lsp.enable('sourcekit')

                        -- vim.lsp.config('omnisharp', {
                        --     handlers = {
                        --         ["textDocument/definition"] = require('omnisharp_extended').handler,
                        --     }
                        -- })
                        -- vim.lsp.enable('omnisharp')
                    end,
                    init = function()
                        -- Errors & Warnings
                        vim.diagnostic.config({
                            virtual_text = true,
                            severity_sort = true,
                            float = {
                                style  = 'minimal',
                                border = 'single',
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
                                vim.keymap.set('n', 'gnl', function() vim.diagnostic.jump({count= 1, float=true}) end, opts)
                                vim.keymap.set('n', 'gbl', function() vim.diagnostic.jump({count=-1, float=true}) end, opts)

                                -- docs
                                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({border='single'}) end, opts)

                                -- code actions
                                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
                                vim.keymap.set('n', '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
                            end,
                        })
                    end,
                    },
                },
            },

        { 'mfussenegger/nvim-dap', },

        { 'Hoffs/omnisharp-extended-lsp.nvim', },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "sunsurfer" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})

