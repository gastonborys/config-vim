syntax enable
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'equalsraf/neovim-gui-shim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hoob3rt/lualine.nvim', { 'tag': 'compat-nvim-0.5' }
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
Plug 'nvim-tree/nvim-web-devicons'

" LSP + herramientas modernas
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'simrat39/rust-tools.nvim'

Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" Autocompletado
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

call plug#end()

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

colorscheme gruvbox
set background=dark
set cursorline
set cursorcolumn
highlight CursorColumn guibg=black ctermbg=black
highlight CursorLine guibg=black ctermbg=black

lua << END
require('lualine').setup()
END

" Mapeo de teclas
let mapleader = " "

tnoremap <C-w><C-\> <C-\><C-N>
nnoremap <C-s> :w<CR>		" Guardar archivo con Control + s
nnoremap <F2> :
nnoremap <F3> :NERDTreeToggle<ENTER>
nnoremap <F4> :bufdo bd<CR>
nnoremap <F5> :source ~/.config/nvim/init.vim<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F10> :qa<CR>		" Salir del vim con F10
nnoremap <C-F10> :qa!<CR>
nnoremap <C-S-z> :u<CR>
nnoremap <C-x>h :%!xxd<CR>								" Modo Hexadecimal
nnoremap <C-x>n :%!xxd -r<CR>							" Salir del modo Hexadecimal
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
nnoremap <leader>rr :!cargo run<CR>
nnoremap <leader>rb :!cargo build<CR>
nnoremap <leader>rt :!cargo test<CR>
nnoremap <leader>rf :!cargo fmt<CR>
nnoremap <leader>rc :!cargo clippy<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> rn :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> K  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>

nmap <leader>gs :G<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gf :Gvdiffsplit!<CR>
nmap <leader>gj :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gp :G pull<CR>
nmap <leader>gu :G push<CR>
nmap <leader>gc :G commit<CR>
nmap <leader>da yitvatp 
nmap <leader>et ysit

"Emmet
let g:user_emmet_mode='a'  "enable all functions, which is equal to
let g:user_emmet_install_global = 1
imap <A-CR> <C-y>,
autocmd FileType html,php,js EmmetInstall
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" vim ripgrep
if executable('rg')
    let g:rg_derive_root='true'
endif

" Tagbar
let g:tagbar_ctags_bin = "/usr/bin/ctags"

"ControlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 30

let g:rtagsUseDefaultMappings = 0
let g:tagalong_filetypes = ['html', 'jsx', 'php', 'typescriptreact', 'xml']


"Moto automático para CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

set mouse=a

lua << EOF
require('lualine').setup()

local ts = require("nvim-treesitter.configs")
ts.setup {
    highlight = {
        enable = true,
    }
}

require("mason").setup()
require("mason-lspconfig").setup({
ensure_installed = { "ts_ls", "rust_analyzer" }
})

local lspconfig = require("lspconfig")
lspconfig.ts_ls.setup {}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_lines = 1000;
  max_num_results = 5;
  sort = true;
})

local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy"
        },
      }
    }
  }
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

EOF
