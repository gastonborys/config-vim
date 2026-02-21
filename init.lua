-- =========================
-- init.lua con Lazy.nvim
-- =========================

-- Suprimir warnings de deprecación (nvim-lspconfig, etc.)
local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if msg:find("deprecated") or msg:find("lspconfig") then return end
  orig_notify(msg, level, opts)
end

local orig_echo = vim.api.nvim_echo
vim.api.nvim_echo = function(chunks, history, opts)
  for _, chunk in ipairs(chunks) do
    if chunk[1] and (chunk[1]:find("deprecated") or chunk[1]:find("lspconfig")) then
      return
    end
  end
  orig_echo(chunks, history, opts)
end

-- Suprimir error de parser de treesitter faltante
vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    local ok, err = pcall(wrapped, bufnr, lang)
    if not ok and err and err:find("Parser could not be created") then return end
    if not ok then error(err) end
  end
end)(vim.treesitter.start)

-- =========================
-- Config básica
-- =========================
vim.opt.syntax = "on"
vim.cmd("filetype plugin indent on")

vim.g.python_host_prog = "/usr/bin/python3"
vim.g.GuiClipboard = 1
vim.opt.guifont = "DejaVuSansMono Nerd Font Mono:h11"

vim.opt.errorbells     = false
vim.opt.expandtab      = false
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.smartindent    = true
vim.opt.number         = true
vim.opt.wrap           = false
vim.opt.smartcase      = true
vim.opt.swapfile       = false
vim.opt.relativenumber = true
vim.opt.ignorecase     = true
vim.opt.backup         = false
vim.opt.undodir        = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile       = true
vim.opt.incsearch      = true
vim.opt.mouse          = "a"
vim.opt.indentexpr     = ""

vim.env.PATH = vim.env.PATH .. ":/usr/local/go/bin"

-- =========================
-- Mapleader (antes de plugins)
-- =========================
vim.g.mapleader = " "

-- =========================
-- Bootstrap Lazy.nvim
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
require("lazy").setup({

		-- UI
		--  { "morhetz/gruvbox",
		--    lazy = false,
		--    priority = 1000,
		--    config = function()
		--      vim.o.background = "dark"
		--      vim.cmd("colorscheme gruvbox")
		--
		--      vim.o.cursorline   = true
		--      vim.o.cursorcolumn = true
		--      vim.api.nvim_set_hl(0, "CursorColumn", { bg = "black" })
		--      vim.api.nvim_set_hl(0, "CursorLine",   { bg = "black" })
		--    end,
		--  },
		--
		{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			require("vscode").setup({
					-- Opciones
					transparent = false,       -- fondo transparente
					italic_comments = true,    -- comentarios en cursiva
					italic_inlayhints = true,  -- inlay hints en cursiva
					terminal_colors = true,    -- aplica al terminal también
					})
		vim.cmd([[colorscheme vscode]])
			vim.o.cursorline   = true
			vim.o.cursorcolumn = true
			vim.api.nvim_set_hl(0, "CursorColumn", { bg = "black" })
			vim.api.nvim_set_hl(0, "CursorLine",   { bg = "black" })

			end,
		},

		{ "hoob3rt/lualine.nvim",
			tag = "compat-nvim-0.5",
			config = function()
				require("lualine").setup()
				end,
		},

		{ "nvim-tree/nvim-web-devicons", lazy = true },

		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch="master"
			},
			config = function()
				require("nvim-treesitter.config").setup({
						ensure_installed = { "typescript", "tsx", "javascript", "rust", "go", "php", "lua" },
						highlight = { enable = true },
						indent = { enable = true },
						textobjects = {
						select = {
						enable = true,
						lookahead = true,
						keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["am"] = "@method.outer",
						["im"] = "@method.inner",
						},
						},
						},
						})
			end,
		},
		-- Prisma syntax highlighting
		{ "prisma/vim-prisma" },

		-- LSP
		{ "neovim/nvim-lspconfig" },

		{ "williamboman/mason.nvim",
			config = function()
				require("mason").setup()
				end,
		},

		{ "williamboman/mason-lspconfig.nvim",
			dependencies = { "williamboman/mason.nvim" },
			config = function()
				require("mason-lspconfig").setup({
						ensure_installed = { "ts_ls", "rust_analyzer", "gopls", "prisma-language-server" },
						})
			end,
		},

		-- Rust tools
		{ "simrat39/rust-tools.nvim",
			ft = "rust",
			config = function()
				local rt = require("rust-tools")
				rt.setup({
						server = {
						on_attach = function(_, bufnr)
						local lmap = function(keys, func)
						vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true })
						end
						lmap("gd",         vim.lsp.buf.definition)
						lmap("gi",         vim.lsp.buf.implementation)
						lmap("gr",         vim.lsp.buf.references)
						lmap("ren",        vim.lsp.buf.rename)
						lmap("K",          vim.lsp.buf.hover)
						lmap("<leader>ca", rt.code_action_group.code_action_group)
						lmap("gp", function() vim.cmd("Lspsaga peek_definition") end)
						end,
						settings = {
						["rust-analyzer"] = {
						cargo       = { allFeatures = true },
						checkOnSave = { command = "clippy" },
						},
						},
						},
				})
			end,
		},

		-- LSPSaga
		{ "nvim-lua/plenary.nvim", lazy = true },

		{ "nvimdev/lspsaga.nvim",
			event = "LspAttach",
			dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
			config = function()
				require("lspsaga").setup({
						ui = {
						title       = true,
						border      = "rounded",
						code_action = "",
						diagnostic  = "",
						},
						})
			end,
		},

		-- Herramientas
		{ "jremmen/vim-ripgrep" },
		{ "tpope/vim-fugitive" },
		{ "kien/ctrlp.vim" },
		{ "AndrewRadev/tagalong.vim" },
		{ "mbbill/undotree" },
		{ "mattn/emmet-vim" },
		{ "preservim/nerdtree" },
		{ "preservim/tagbar" },
		{ "jiangmiao/auto-pairs" },
		{ "tpope/vim-surround" },
		{ "othree/csscomplete.vim" },
		{ "mg979/vim-visual-multi", branch = "master" },
		{ "mxw/vim-jsx" },
		{ "editorconfig/editorconfig-vim" },

		-- Copilot
		{ "github/copilot.vim", lazy = false },

		-- Autocompletado
		{ "hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp     = require("cmp")
				local luasnip = require("luasnip")
				require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

				cmp.setup({
						snippet = {
						expand = function(args) luasnip.lsp_expand(args.body) end,
						},
						mapping = cmp.mapping.preset.insert({
								["<C-n>"]     = cmp.mapping.select_next_item(),
								["<C-p>"]     = cmp.mapping.select_prev_item(),
								["<Down>"]    = cmp.mapping.select_next_item(),
								["<Up>"]      = cmp.mapping.select_prev_item(),
								["<C-Space>"] = cmp.mapping.complete(),
								["<CR>"]      = cmp.mapping.confirm({ select = true }),
								["<Tab>"] = cmp.mapping(function(fallback)
										if luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
										else fallback() end
										end, { "i", "s" }),
								["<S-Tab>"] = cmp.mapping(function(fallback)
										if luasnip.jumpable(-1) then luasnip.jump(-1)
										else fallback() end
										end, { "i", "s" }),
								}),
						sources = cmp.config.sources({
								{ name = "nvim_lsp" },
								{ name = "luasnip"  },
								{ name = "buffer"   },
								{ name = "path"     },
								}),
				})
			end,
		},

		{
			"numToStr/Comment.nvim",
			keys = {
				{ "<C-_>", mode = "n" },  -- Ctrl+/ en normal
				{ "<C-_>", mode = "v" },  -- Ctrl+/ en visual
			},
			config = function()
				require("Comment").setup({
					toggler = {
						line = "<C-_>",   -- normal mode
						block = "<C-S-_>", -- bloque, opcional
					},
					opleader = {
						line = "<C-_>",   -- operador + motion
						block = "<C-S-_>",
					},
				})
			end,
		}
	}, {
		checker = { enabled = false },
})

-- =========================
-- LSP con nvim-lspconfig
-- =========================
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

local on_attach = function(_, bufnr)
  local lmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, desc = desc })
  end
  -- lmap("gd",         vim.lsp.buf.definition,     "Go to definition")
  lmap("gd", function()
	  vim.lsp.buf.definition({
		  on_list = function(opts)
			  if #opts.items == 1 then
				  vim.cmd("edit " .. opts.items[1].filename)
				  vim.api.nvim_win_set_cursor(0, { opts.items[1].lnum, 0 })
			  else
				  vim.fn.setqflist({}, " ", opts)
				  vim.cmd("copen")
			  end
		  end,
	  })
  end)
  lmap("gi",         vim.lsp.buf.implementation, "Go to implementation")
  lmap("gr",         vim.lsp.buf.references,     "References")
  lmap("ren",        vim.lsp.buf.rename,         "Rename")
  lmap("K",          vim.lsp.buf.hover,          "Hover docs")
  lmap("<leader>ca", vim.lsp.buf.code_action,    "Code action")
  lmap("gp", function() vim.cmd("Lspsaga peek_definition") end, "Peek definition")
end

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach    = on_attach,
})

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach    = on_attach,
  settings = {
    gopls = {
      gofumpt     = true,
      analyses    = { unusedparams = true },
      staticcheck = true,
    },
  },
})

lspconfig.prismals.setup({
  capabilities = capabilities,
  on_attach    = on_attach,
})

-- Rust lo maneja rust-tools directamente

-- =========================
-- Keymaps
-- =========================
local map = vim.keymap.set

-- Terminal
map("t", "<C-w><C-\\>", "<C-\\><C-N>")

-- Guardar / salir
map("n", "<C-s>",   ":w<CR>",                              { silent = true })
map("n", "<F2>",    ":",                                   {})
map("n", "<F3>",    ":NERDTreeToggle<CR>",                 { silent = true })
map("n", "<F4>",    ":bufdo bd<CR>",                       { silent = true })
map("n", "<F5>",    ":source ~/.config/nvim/init.lua<CR>", { silent = true })
map("n", "<F8>",    ":TagbarToggle<CR>",                   { silent = true })
map("n", "<F10>",   ":qa<CR>",                             { silent = true })
map("n", "<C-F10>", ":qa!<CR>",                            { silent = true })
map("n", "<C-S-z>", ":u<CR>",                              { silent = true })

-- Hex
map("n", "<C-x>h", ":%!xxd<CR>",    { silent = true })
map("n", "<C-x>n", ":%!xxd -r<CR>", { silent = true })

-- Clipboard
map("i", "<C-v>", '<ESC>"+pa')
map("v", "<C-c>", '"+y')
map("v", "<C-d>", '"+d')

-- Tamaño de ventanas
map("n", "-", "<C-W>-")
map("n", "+", "<C-W>+")
map("n", ">", "<C-W><")
map("n", "<", "<C-W>>")

-- Moverse entre ventanas
map("n", "<leader>h", ":wincmd h<CR>", { silent = true })
map("n", "<leader>j", ":wincmd j<CR>", { silent = true })
map("n", "<leader>k", ":wincmd k<CR>", { silent = true })
map("n", "<leader>l", ":wincmd l<CR>", { silent = true })
map("n", "<leader>1", ":wincmd o<CR>", { silent = true })
map("n", "<leader>2", ":wincmd v<CR>", { silent = true })
map("n", "<leader>3", ":wincmd S<CR>", { silent = true })
map("n", "<leader>4", ":wincmd q<CR>", { silent = true })

-- Buffers
map("n", "<leader>q",  ":bp<CR>",           { silent = true })
map("n", "<leader>p",  ":bn<CR>",           { silent = true })
map("n", "<leader>cc", ":bd<bar>bp<CR>",    { silent = true })
map("n", "<leader>u",  ":UndotreeShow<CR>", { silent = true })
map("n", "<leader>0",  ":q<CR>",            { silent = true })
map("n", "qq",         "gt",                { silent = true })

-- Insert omnicompletion
map("i", "<C-Space>", "<C-x><C-o>")

-- Git (vim-fugitive)
map("n", "<leader>gs",  ":G<CR>",                   { silent = true })
map("n", "<leader>gd",  ":Gdiff<CR>",               { silent = true })
map("n", "<leader>gw",  ":Gwrite<CR>",              { silent = true })
map("n", "<leader>gf",  ":Gvdiffsplit!<CR>",        { silent = true })
map("n", "<leader>gj",  ":diffget //2<CR>",         { silent = true })
map("n", "<leader>gl",  ":diffget //3<CR>",         { silent = true })
map("n", "<leader>gc",  ":G commit<CR>",            { silent = true })
map("n", "<leader>gp",  ":G pull<CR>",              { silent = true })
map("n", "<leader>gu",  ":G push<CR>",              { silent = true })
map("n", "<leader>grn", ":Greset --hard HEAD~<CR>", { silent = true })

-- Diagnósticos
map("n", "<leader>e", vim.diagnostic.open_float, { silent = true })
map("n", "[d",        vim.diagnostic.goto_prev,  { silent = true })
map("n", "]d",        vim.diagnostic.goto_next,  { silent = true })

-- =========================
-- Copilot
-- =========================
vim.g.copilot_enabled    = false
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-l>", function()
  return vim.fn["copilot#Accept"]("")
end, { silent = true, expr = true, replace_keycodes = false })

local copilot_enabled = false
vim.keymap.set("n", "<leader>cp", function()
  copilot_enabled = not copilot_enabled
  local ok, err = pcall(vim.cmd, copilot_enabled and "Copilot enable" or "Copilot disable")
  if ok then
    print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
  else
    vim.notify("Copilot no está instalado: " .. tostring(err), vim.log.levels.WARN)
  end
end)
