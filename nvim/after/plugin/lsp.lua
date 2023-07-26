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

lsp.setup()
