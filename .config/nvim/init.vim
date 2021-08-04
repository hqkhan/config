" General settings import
source ~/.config/nvim/settings.vim

" Plugin config imports
source ~/.config/nvim/plug-config/fugitive.vim
source ~/.config/nvim/plug-config/fzf.vim
source ~/.config/nvim/plug-config/nerd-tree.vim
source ~/.config/nvim/plug-config/lightline.vim
source ~/.config/nvim/plug-config/undotree.vim
source ~/.config/nvim/plug-config/ripgrep.vim

" LSP 
lua require ("lsp-config")
lua require ("compe-config")
" luafile ~/.config/nvim/lua/plugins/lsp-config.lua
" luafile ~/.config/nvim/lua/plugins/compe-config.lua

luafile ~/.config/nvim/lsp/dockerls.lua
luafile ~/.config/nvim/lsp/python-ls.lua

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme -- Gruvbox
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

set t_Co=256
set background=dark
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup numbertoggle
  autocmd!
  autocmd BufWinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set colorcolumn=90
highlight ColorColumn ctermbg=0 guibg=grey

nnoremap <leader>yy "+y
