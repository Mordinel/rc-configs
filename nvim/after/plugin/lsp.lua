local lsp = require("lsp-zero")
lsp.preset("recommended")

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function()
    local opts = {buffer = bufnr, remap = false}
    vim.diagnostic.config({ virtual_text = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
end)

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

        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end,
})

-- rust-analyzer
--require('lspconfig').rust_analyzer.setup {
--    cmd = { "rust-analyzer" },
--}

-- Pylsp
--lsp.configure('pylsp', {
--    settings = {
--        pylsp = {
--            plugins = {
--                pycodestyle = {enabled = false},
--                pyflakes = {enabled = false},
--            },
--        },
--    },
--})

-- OCaml
--require('lspconfig').ocamllsp.setup{}

-- Omnisharp Extended
--local omnisharp_ext = require("omnisharp_extended")
--lsp.configure('omnisharp', {
--    handlers = {
--        ["textDocument/definition"] = omnisharp_ext.handler,
--    }
--})

-- Sourcekit
--require('lspconfig').sourcekit.setup {
--  cmd = {'/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp'}
--}

lsp.setup()
