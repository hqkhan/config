let mapleader = ","
syntax on

set showtabline=2
set wildmenu
set nowrap
set termguicolors
set guicursor=
set noshowmatch
set relativenumber
set hlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set noshowmode
set clipboard+=unnamedplus

au BufRead,BufNewFile *.py set expandtab
set autoindent
filetype plugin indent on

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Edit init.vim quickly
nnoremap <leader><CR> :tabnew<CR><bar>:e ~/.config/nvim/init.vim<CR>:cd %:p:h<cr>:pwd<cr>

" source init.vim file
nnoremap <leader>ss :source ~/.config/nvim/init.vim<CR>

" Sets how many lines of history VIM has to remember
set history=500

nnoremap <silent> <S-k> <PageUp>zz
nnoremap <silent> <S-j> <PageDown>zz
nnoremap <leader>ll :set invrelativenumber<CR> 
nnoremap <leader>pp :set invpaste paste?<CR>

" Vim tabs hotkey
nnoremap <leader>tn :tabnew <bar> BufExplorer<CR>
nnoremap gh :tabprev<cr>
nnoremap gl :tabnext<cr>
nnoremap <leader>bd :tabclose<CR>

" Quick resizing of windows
nnoremap <S-h> 5<C-w>>
nnoremap <S-l> 5<C-w><

" Remap ctrl carrot
nnoremap <C-e> <C-^>

" Copy whole line
nnoremap Y y$

" Keeping things centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Undo break points
inoremap , ,<c-g>u
inoremap ( (<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap ) )<c-g>u

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
