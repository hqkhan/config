let mapleader = ","
syntax on

set termguicolors
set showtabline=2
set wildmenu
set nowrap
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
set cursorline

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
map <leader>bd :bd<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
nnoremap <leader>yy "+y

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" source init.vim file
nnoremap <leader>ss :source ~/.config/nvim/init.vim<CR>

" Sets how many lines of history VIM has to remember
set history=500

nnoremap <silent> <S-k> <PageUp>zz
nnoremap <silent> <S-j> <PageDown>zz
vnoremap <silent> <S-k> <PageUp>zz
vnoremap <silent> <S-j> <PageDown>zz
nnoremap <leader>ll :set invrelativenumber<CR> :set nonu<CR>
nnoremap <leader>pp :set invpaste paste?<CR>

" Quick resizing of windows
nnoremap <S-h> 5<C-w>>
nnoremap <S-l> 5<C-w><

" Remap ctrl carrot
nnoremap <C-e> <C-^>
inoremap <C-e> <Esc><C-^>

" Copy whole line
nnoremap Y y$

" Keeping things centered
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <C-p> :echo expand('%:p')<CR>

" Undo break points
inoremap , ,<c-g>u
inoremap ( (<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap ) )<c-g>u

" Quickfix
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

nnoremap <silent> <leader>cn :cn<CR>
nnoremap <silent> <leader>cp :cp<CR>
nnoremap <leader>cq :call QuickfixToggle()<cr>

cnoremap <leader>w execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

cmap <C-j> <Down>
cmap <C-k> <Up>

nnoremap <C-j> j<C-E>
nnoremap <C-k> k<C-Y>
