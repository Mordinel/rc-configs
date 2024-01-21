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

-- Omnisharp Extended
local omnisharp_ext = require("omnisharp_extended")
lsp.configure('omnisharp', {
    handlers = {
        ["textDocument/definition"] = omnisharp_ext.handler,
    }
})

-- Sourcekit
require('lspconfig').sourcekit.setup {
  cmd = {'/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp'}
}
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    --enable omnifunc completion
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- buffer local mappings
    local opts = { buffer = ev.buf }
    -- go to definition
    vim.keymap.set('n','gd',vim.lsp.buf.definition,opts)
    --puts doc header info into a float page
    vim.keymap.set('n','K',vim.lsp.buf.hover,opts)

    -- workspace management. Necessary for multi-module projects
    --vim.keymap.set('n','<space>wa',vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n','<space>wr',vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n','<space>wl',function()
    --        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end,opts)

    -- add LSP code actions
    vim.keymap.set({'n','v'},'<space>ca',vim.lsp.buf.code_action,opts)                

    -- find references of a type
    vim.keymap.set('n','gr',vim.lsp.buf.references,opts)
  end,
})

lsp.setup()
