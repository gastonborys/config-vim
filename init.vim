syntax on
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'								
Plug 'tpope/vim-fugitive'								" Plugin Git para VIM
Plug 'leafgarland/typescript-vim'						" Integración TypeScript para vim
Plug 'vim-utils/vim-man'								" Utilidad Manuales para vim
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'				" Buscador de archivos
Plug 'mbbill/undotree'									" explorador para deshacer cambios realizados
Plug 'mattn/emmet-vim'									" snippets para html
Plug 'preservim/nerdtree'								" Explorador de archivos
Plug 'preservim/tagbar'									" Plugin para las funciones, variables y clases en proyectos php 
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'rust-lang/rust.vim'								" Modo rust
Plug 'jiangmiao/auto-pairs'								" Plugin para cerrar automágicamente las comillas, parentesis, corchetes y llaves.
Plug 'git@github.com:neoclide/coc.nvim', {'branch': 'release'}
Plug 'othree/csscomplete.vim'							" Autocompletado de css
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'ThePrimeagen/vim-be-good'
Plug 'vim-airline/vim-airline'
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
" Mapeo de teclas
let mapleader = " "

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

"Emmet
let g:user_emmet_mode='a'  "enable all functions, which is equal to
let g:user_emmet_install_global = 0
imap <A-CR> <C-y>,
autocmd FileType html,php EmmetInstall


" vim ripgrep
if executable('rg')
	let g:rg_derive_root='true'
endif

" Tagbar
let g:tagbar_ctags_bin = "/opt/bin/ctags"

"ControlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 30

let g:rtagsUseDefaultMappings = 0


"Moto automático para CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
