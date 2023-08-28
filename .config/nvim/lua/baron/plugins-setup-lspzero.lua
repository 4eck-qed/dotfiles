local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- reload nvim @save of this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- add your plugins here --
	------------
	--| Basics --
	use("wbthomason/packer.nvim") -- package manager
	use("nvim-lua/plenary.nvim") -- used by other plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
	use("tpope/vim-commentary") -- comment/uncomment stuff
	use("mbbill/undotree") -- undo history
	-- git
	use("tpope/vim-fugitive") -- commands
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
	------------------
	--|      UI      --
	use("nvim-lualine/lualine.nvim") -- statusbar at the bottom
	use("nvim-tree/nvim-web-devicons") -- vs-code like icons
    use("Mofiqul/vscode.nvim") -- vscode theme
    use("folke/zen-mode.nvim")
	--------------------
	--| Language Stuff --
    --> formatting & linting 
    use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context")

    use({ -- Diagnostics list
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
    })

    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    --> LSP
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lua'},
        {'saadparwaiz1/cmp_luasnip'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},     -- Required
        {'rafamadriz/friendly-snippets'},
      }
    }
    use("rust-lang/rust.vim") -- rust
    use("github/copilot.vim")
	----------------
	-- Navigation --
	use("nvim-tree/nvim-tree.lua") -- file explorer
	use("theprimeagen/harpoon") -- bookmark files
	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { { "nvim-lua/plenary.nvim" } } }) -- fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
	use("szw/vim-maximizer") -- maxmize splits and restore back to original size
    ---------------
    --  Utils   --
    
	-- -- -- -- -- -- -- -- ---
	if packer_bootstrap then
		require("packer").sync()
	end
end)
