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

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

lsp.setup()
