syntax enable
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'hoob3rt/lualine.nvim', { 'tag': 'compat-nvim-0.5' }
Plug 'jremmen/vim-ripgrep'								
Plug 'tpope/vim-fugitive'								" Plugin Git para VIM
Plug 'leafgarland/typescript-vim'						" Integración TypeScript para vim
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'				" Buscador de archivos
Plug 'git@github.com:AndrewRadev/tagalong.vim'
Plug 'mbbill/undotree'									" explorador para deshacer cambios realizados
Plug 'mattn/emmet-vim'									" snippets para html
Plug 'preservim/nerdtree'								" Explorador de archivos
Plug 'vim-scripts/dbext.vim'
Plug 'preservim/tagbar'									" Plugin para las funciones, variables y clases en proyectos php 
Plug 'nvim-tree/nvim-tree.lua'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'rust-lang/rust.vim'								" Modo rust
Plug 'jiangmiao/auto-pairs'								" Plugin para cerrar automágicamente las comillas, parentesis, corchetes y llaves.
Plug 'tpope/vim-surround'
Plug 'git@github.com:neoclide/coc.nvim', {'branch': 'release'}
Plug 'othree/csscomplete.vim'							" Autocompletado de css
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'peitalin/vim-jsx-typescript'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

set noerrorbells
set tabstop=4
set shiftwidth=4
set expandtab
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

let g:python_host_prog="/usr/bin/python3.8"

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

nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <buffer> <leader>gy <Plug>(coc-type-definition)
nmap <buffer> <leader>gi <Plug>(coc-implementation)
nnoremap <buffer> <leader>cr :CocRestart
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

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

set mouse=a

