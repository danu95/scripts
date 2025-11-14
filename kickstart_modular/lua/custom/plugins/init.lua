-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {

	-- vimtex
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
		end,
	},

	-- Theme picker
	{
		"vague2k/huez.nvim",
		import = "huez-manager.import",
		branch = "stable",
		event = "UIEnter",
		dependencies = {
			{ "catppuccin/nvim", name = "catppuccin" },
			{ "rose-pine/neovim", name = "rose-pine" },
			{ "rebelot/kanagawa.nvim", name = "kanagawa" },
			{ "EdenEast/nightfox.nvim", name = "nightfox" },
			{ "ellisonleao/gruvbox.nvim", name = "gruvbox" },
			{ "sainnhe/everforest", name = "everforest" },
			{ "shaunsingh/nord.nvim", name = "nord" },
			{ "scottmckendry/cyberdream.nvim", name = "cyberdream" },
			{ "craftzdog/solarized-osaka.nvim", name = "solarized-osaka" },
		},
		config = function()
			require("huez").setup({
				themes = {
					-- Catppuccin
					{
						name = "catppuccin",
						plugin = "catppuccin/nvim",
						config = function()
							require("catppuccin").setup({
								flavour = "mocha", -- latte, frappe, macchiato, mocha
							})
						end,
					},
					-- Rose Pine
					{
						name = "rose-pine",
						plugin = "rose-pine/neovim",
						config = function()
							require("rose-pine").setup({
								variant = "moon",
								dark_variant = "moon",
							})
						end,
					},
					-- Kanagawa
					{
						name = "kanagawa",
						plugin = "rebelot/kanagawa.nvim",
						config = function()
							require("kanagawa").setup({
								theme = "wave", -- wave, dragon, lotus
							})
						end,
					},
					-- Nightfox
					{
						name = "nightfox",
						plugin = "EdenEast/nightfox.nvim",
					},
					-- Gruvbox
					{
						name = "gruvbox",
						plugin = "ellisonleao/gruvbox.nvim",
					},
					-- Everforest
					{
						name = "everforest",
						plugin = "sainnhe/everforest",
					},
					-- Nord
					{
						name = "nord",
						plugin = "shaunsingh/nord.nvim",
					},
					-- Cyber Dream
					{
						name = "cyberdream",
						plugin = "scottmckendry/cyberdream.nvim",
						config = function()
							require("cyberdream").setup({})
							vim.cmd.colorscheme("cyberdream")
						end,
					},
					-- Solarized Osaka
					{
						name = "osaka",
						plugin = "craftzdog/solarized-osaka.nvim",
						config = function()
							require("solarized-osaka").setup({})
							vim.cmd.colorscheme("solarized-osaka")
						end,
					},
				},
			})
		end,
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = function()
			local db = require("dashboard")
			db.setup({
				theme = "hyper", -- or 'doom', depending on your preference
				config = {
					week_header = { enable = true }, -- optional: show current week at top
					shortcut = {
						{
							desc = "󰊳 Update",
							group = "@property",
							action = "Lazy update",
							key = "u",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Apps",
							group = "DiagnosticHint",
							action = "Telescope app",
							key = "a",
						},
						{
							desc = " dotfiles",
							group = "Number",
							action = "Telescope dotfiles",
							key = "d",
						},
					},

					packages = { enable = true }, -- shows how many plugins loaded

					project = {
						enable = true,
						limit = 8,
						icon = " ",
						label = "Projects",
						action = "Telescope find_files cwd=",
					},

					mru = {
						enable = true,
						limit = 10,
						icon = " ",
						label = "Recent files",
						cwd_only = false,
					},

					footer = {
						"",
						"🎯 Built with Neovim + Love",
						"💡 Tip: Press <Space> to start quickly",
					},
				},
			})
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- Override markdown rendering so that cmp and other plugins use Treesitter
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					-- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- Easier presets
			presets = {
				bottom_search = true, -- classic bottom cmdline for search
				command_palette = true, -- position cmdline and popupmenu together
				long_message_to_split = true, -- long messages go into a split
				inc_rename = false, -- set to true if you use inc-rename.nvim
				lsp_doc_border = false, -- add border to hover docs/signature help
			},
			views = {
				notify = {
					replace = true,
					position = {
						row = "100%", -- bottom
						col = "100%", -- right
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						stages = "fade_in_slide_out",
						timeout = 3000,
						fps = 60,
						top_down = false, -- bottom-right stacking
						merge_duplicates = true, -- combine identical notifications
					})
					vim.notify = require("notify") -- make it the global notify()
				end,
			},
		},
	},

	-- {
	--   'iamcco/markdown-preview.nvim',
	--   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
	--   ft = { 'markdown' },
	--   build = function()
	--     vim.cmd 'packadd markdown-preview.nvim' -- load plugin first
	--     vim.fn['mkdp#util#install']()
	--   end,
	--   init = function()
	--     -- Set the root folder for the markdown preview server to the current file's folder
	--     vim.g.mkdp_images_path = 'C:/Users/vonkaeneld/OneDrive - Post CH AG/1 Projects (does have a end)/media'
	--   end,
	-- },

	-- {
	-- "iamcco/markdown-preview.nvim",
	-- ft = "markdown",
	-- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- build = "cd app && npm install",
	-- init = function()
	-- vim.g.mkdp_images_path = "C:/Users/vonkaeneld/OneDrive - Post CH AG/1 Projects (does have a end)/media"
	-- end,
	-- },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			latex = { enabled = false },
		},
	},
	--
	--
	--

	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true, -- Replace netrw
			columns = {
				"icon", -- Show file icons
				"permissions", -- Show permissions (optional)
				-- "size",        -- Show file size
				-- "mtime",       -- Show last modified time
			},
			view_options = {
				show_hidden = true, -- Show dotfiles by default
				is_hidden_file = function(name, bufnr)
					-- Example: hide `.git` folder but show others
					return name == ".git"
				end,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},
			float = {
				padding = 2,
				max_width = 80,
				max_height = 20,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			keymaps = {
				["<CR>"] = "actions.select", -- Open
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<Esc>"] = "actions.close", -- Close with Esc
				["<C-c>"] = "actions.close", -- Close with Ctrl+C
				["-"] = "actions.parent", -- Go up one directory
				["g."] = "actions.toggle_hidden",
				["q"] = "actions.close",
			},
			git = {
				enable = true, -- Enable git integration
				status_symbols = {
					added = "",
					modified = "",
					removed = "",
				},
			},
		},
		dependencies = {
			{ "nvim-mini/mini.icons", opts = {} },
			-- OR use this instead if you prefer devicons:
			-- "nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function(_, opts)
			require("oil").setup(opts)

			-- Keymaps outside Oil (for opening)
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })
			vim.keymap.set("n", "<leader>e", function()
				require("oil").open_float()
			end, { desc = "Open Oil in floating window" })
		end,
	},

	-- {
	--   'obsidian-nvim/obsidian.nvim',
	--   version = '*',
	--   dependencies = {
	--     'nvim-lua/plenary.nvim',
	--     'nvim-treesitter/nvim-treesitter',
	--   },
	--   ft = 'markdown',
	--   event = 'VeryLazy',
	--
	--   keys = {
	--     { '<leader>oo', '<cmd>Obsidian search<cr>', desc = 'Search notes' },
	--     { '<leader>of', '<cmd>Obsidian follow-link<cr>', desc = 'Follow link under cursor' },
	--     { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Show backlinks' },
	--     { '<leader>or', '<cmd>Obsidian rename<cr>', desc = 'Rename note and update links' },
	--   },
	--
	--   opts = {
	--     workspaces = {
	--       {
	--         name = 'work',
	--         path = 'C:\\Users\\vonkaeneld\\OneDrive - Post CH AG\\1 Projects (does have a end)',
	--       },
	--     },
	--     frontmatter = { enabled = false },
	--     ui = {
	--       enable = false,
	--     },
	--     templates = { subdir = nil, date_format = nil, time_format = nil },
	--
	--     legacy_commands = false,
	--     cache = { enabled = false},
	--     completion = {
	--       blink = false,
	--       nvim_comp = false,
	--       min_cahrs = 2,
	--       match_case = false,
	--       create_new = false,
	--     },
	--   },
	-- },

	{
		"OXY2DEV/helpview.nvim",
		lazy = false,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},

	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}
