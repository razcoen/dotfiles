local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons"

  use { 'numToStr/Comment.nvim', config = "require('plugins.comment')" }

  use { "windwp/nvim-autopairs", config = "require('plugins.autopairs')" }

  use { "kyazdani42/nvim-tree.lua", config = "require('plugins.nvim-tree')" }

  use { "lukas-reineke/indent-blankline.nvim", config = "require('plugins.indentline')" }

  use { 'stevearc/dressing.nvim', requires = 'MunifTanjim/nui.nvim', config = "require('plugins.dressing')" }
  use { 'romgrk/barbar.nvim', config = "require('plugins.barbar')" }
  use "ahmedkhalf/project.nvim"
  use { "lewis6991/impatient.nvim", config = "require('plugins.impatient')" }
  -- use "RRethy/vim-illuminate" -- highlight current word

  -- Colorschemes
  -- use "morhetz/gruvbox"
  use { "ellisonleao/gruvbox.nvim" }
  -- use "ghifarit53/tokyonight-vim"
  -- use "joshdick/onedark.vim"
  -- use "sainnhe/everforest"
  -- use "dracula/vim"
  -- use "tomasiser/vim-code-dark"
  -- use "rebelot/kanagawa.nvim"
  -- use 'EdenEast/nightfox.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use "projekt0n/github-nvim-theme"
  use "ayu-theme/ayu-vim"
  use "Shatur/neovim-ayu"
  use "shaunsingh/nord.nvim"
  -- use "lourenci/github-colors"
  use "krfl/fleetish-vim"
  -- use "bluz71/vim-moonfly-colors"
  use "cocopon/iceberg.vim"
  use "razcoen/fleet.nvim"
  use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim"
  }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", config = "require('plugins.cmp')" } -- The completion plugin
  use "hrsh7th/cmp-buffer"                                      -- buffer completions
  use "hrsh7th/cmp-path"                                        -- path completions
  use "hrsh7th/cmp-cmdline"                                     -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use { "heavenshell/vim-jsdoc", run = "make install", ft = { 'javascript', 'javascript.jsx', 'typescript' } }

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    run = ":MasonUpdate"             -- :MasonUpdate updates registry contents
  }
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "lukas-reineke/lsp-format.nvim"
  use {
    "ray-x/lsp_signature.nvim",
    config = "require('lsp_signature').setup({})"
  }
  use "nvim-lua/lsp_extensions.nvim"
  use 'towolf/vim-helm' -- sets the filetype to be helm

  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    config = "require('plugins.telescope')",
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' }
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'cljoly/telescope-repo.nvim' }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = "require('plugins.treesitter')",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Git
  use { "lewis6991/gitsigns.nvim", config = "require('plugins.gitsigns')" }
  use "tpope/vim-fugitive"

  -- Rust
  use { "simrat39/rust-tools.nvim", config = "require('rust-tools').setup({})" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
