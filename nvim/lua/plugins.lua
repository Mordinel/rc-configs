vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Colourschemes
  use 'Mordinel/vim-sunsurfer'
  use 'Mordinel/auto-dark-mode.nvim'

  -- Git
  use 'tpope/vim-fugitive'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
  use 'nvim-treesitter/playground'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- Autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  --use { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' }

  -- for TeX
  --use {
  --  'lervag/vimtex',
  --  tag = "v2.16",
  --  opt = true,
  --  config = function()
  --      vim.g.vimtex_view_method = "zathura"
  --  end,
  --  ft = 'tex',
  --}

  --use {
  --    'neoclide/coc.nvim',
  --    branch = 'release',
  --}

  -- for viewing decompiled .NET IL code as C#
  -- use 'Hoffs/omnisharp-extended-lsp.nvim'
end)
