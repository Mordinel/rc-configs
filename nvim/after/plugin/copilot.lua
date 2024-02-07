vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = false

local opts = {expr = true, replace_keycodes = false}
vim.keymap.set('i', '<C-Return>', 'copilot#Accept("\\<CR>")', opts)
vim.keymap.set('i', '<C-J>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-K>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-suggest)')
vim.keymap.set('i', '<C-Backspace>', '<Plug>(copilot-dismiss)')

