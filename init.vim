syntax enable
call plug#begin('~/.vim/plugged')

" Temas y UI
Plug 'morhetz/gruvbox'
Plug 'equalsraf/neovim-gui-shim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hoob3rt/lualine.nvim', { 'tag': 'compat-nvim-0.5' }
Plug 'nvim-tree/nvim-web-devicons'

" Herramientas de desarrollo
Plug 'jremmen/vim-ripgrep'								
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'git@github.com:AndrewRadev/tagalong.vim'
Plug 'mbbill/undotree'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'othree/csscomplete.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'peitalin/vim-jsx-typescript'
Plug 'editorconfig/editorconfig-vim'

" LSP y herramientas modernas
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'simrat39/rust-tools.nvim'

" Autocompletado y snippets
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

call plug#end()

" =========================
" Config básicas
" =========================
let g:python_host_prog="/usr/bin/python3"
let g:GuiClipboard = 1

set indentexpr=
filetype plugin indent on
set noerrorbells
set noexpandtab
set tabstop=4
set shiftwidth=4
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set relativenumber
set ignorecase
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set mouse=a

colorscheme gruvbox
set background=dark
set cursorline
set cursorcolumn
highlight CursorColumn guibg=black ctermbg=black
highlight CursorLine guibg=black ctermbg=black

" =========================
" Lualine
" =========================
lua << END
require('lualine').setup()
END


" =========================
" Keymaps
" =========================
let mapleader = " "

" =========================
" Mapeos generales
" =========================
tnoremap <C-w><C-\> <C-\><C-N>
nnoremap <C-s> :w<CR>										" Guardar archivo con Control + s
nnoremap <F2> :
nnoremap <F3> :NERDTreeToggle<ENTER>
nnoremap <F4> :bufdo bd<CR>
nnoremap <F5> :source ~/.config/nvim/init.vim<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F10> :qa<CR>										" Salir del vim con F10
nnoremap <C-F10> :qa!<CR>
nnoremap <C-S-z> :u<CR>
nnoremap <C-x>h :%!xxd<CR>									" Modo Hexadecimal
nnoremap <C-x>n :%!xxd -r<CR>								" Salir del modo Hexadecimal
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

"Mapeos para el tamaño de los buffers
nnoremap - <C-W>-
nnoremap + <C-W>+
nnoremap > <C-W><
nnoremap < <C-W>>

" Mapeo de teclas para moverse entre buffers 
nnoremap <leader>h :wincmd h<CR>							" Moverse a la pantalla de la izquierda
nnoremap <leader>j :wincmd j<CR>							" Moverse a la pantalla de abajo
nnoremap <leader>k :wincmd k<CR>							" Moverse a la pantalla de arriba
nnoremap <leader>l :wincmd l<CR>							" Moverse a la pantalla de la derecha
nnoremap <leader>1 :wincmd o<CR>							" Un solo buffer
nnoremap <leader>2 :wincmd v<CR>							" Partir Buffer de manera vertical
nnoremap <leader>3 :wincmd S<CR>							" Partir buffer de manera horizontal
nnoremap <leader>4 :wincmd q<CR>                            " Cierro la pantalla actual
nnoremap <leader>q :bp<CR>									" Archivo anterior
nnoremap <leader>p :bn<CR>									" Archivo siguiente
nnoremap <leader>cc :bd<bar>bp<CR>  							" Cerrar Archivo
nnoremap <leader>u :UndotreeShow<CR> " Cierro el explorador del deshacer
nnoremap <leader>0 :q<CR>
inoremap <C-Space> <C-x><C-o>
nnoremap <silent>qq gt


"=========================
" Mapeos de Git (vim-fugitive)
" =========================
nnoremap <leader>gs :G<CR>           " Git status
nnoremap <leader>gd :Gdiff<CR>       " Diff del archivo
nnoremap <leader>gw :Gwrite<CR>      " Guardar cambios en git
nnoremap <leader>gf :Gvdiffsplit!<CR> " Abrir diff vertical
nnoremap <leader>gj :diffget //2<CR>  " Tomar cambios de base //2
nnoremap <leader>gl :diffget //3<CR>  " Tomar cambios de otro //3
nnoremap <leader>gc :G commit<CR>     " Git commit
nnoremap <leader>gp :Gpull<CR>       " Git pull
nnoremap <leader>gu :Gpush<CR>       " Git push
nnoremap <leader>grn :Greset --hard HEAD~<CR> " Resetear HEAD anterior

"=========================
" Mapeos de Git (vim-fugitive)
" =========================
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> ren :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> K  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>


" =========================
" Emmet
" =========================
let g:user_emmet_mode='a'
let g:user_emmet_install_global = 1
imap <A-CR> <C-y>,
autocmd FileType html,php,js EmmetInstall
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" =========================
" Mason + LSP
" =========================
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "ts_ls", "rust_analyzer", "gopls" }
})

local lspconfig = require("lspconfig")

-- TypeScript
lspconfig.ts_ls.setup {}

-- Go
lspconfig.gopls.setup({
    settings = {
        gopls = {
            gofumpt = true,
            analyses = { unusedparams = true },
            staticcheck = true,
        }
    }
})

-- Rust
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        end,  -- <--- FIN de la función on_attach
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy" },
            }
        },
    }, -- <--- FIN de server
}) -- <--- FIN de rt.setup
EOF

" =========================
" nvim-cmp + LuaSnip
" =========================
lua << EOF
local cmp = require'cmp'
local luasnip = require'luasnip'

-- Cargar todos los snippets Lua de ~/.config/nvim/snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})
EOF
