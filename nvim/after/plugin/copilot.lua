local opts = {expr = true, replace_keycodes = false}
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', opts)
vim.keymap.set('i', '<C-N>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-P>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-Backspace>', '<Plug>(copilot-dismiss)')
vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = true

