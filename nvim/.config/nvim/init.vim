call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'folke/lsp-colors.nvim'
call plug#end()

" General settings import
source ~/.config/nvim/settings.vim

" Plugin config imports
source ~/.config/nvim/plug-config/fugitive.vim
source ~/.config/nvim/plug-config/fzf.vim
source ~/.config/nvim/plug-config/nerd-tree.vim
source ~/.config/nvim/plug-config/lightline.vim
source ~/.config/nvim/plug-config/undotree.vim
source ~/.config/nvim/plug-config/ripgrep.vim
luafile ~/.config/nvim/lua/treesitter.lua

" LSP 
source ~/.config/nvim/lua/lsp-config.vim
luafile ~/.config/nvim/lua/compe-config.lua
luafile ~/.config/nvim/lua/dockerls.lua
luafile ~/.config/nvim/lua/lsp-colors.lua
luafile ~/.config/nvim/lua/python-ls.lua
luafile ~/.config/nvim/lua/lua-ls.lua

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('+termguicolors')
    let &t_8f="/<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="/<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
let g:nvcode_termcolors=256
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup numbertoggle
  autocmd!
  autocmd BufWinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" set colorcolumn=90
" highlight ColorColumn ctermbg=0 guibg=grey

nnoremap <leader>yy "+y

set background=dark
let g:gruvbox_bold=0
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox 
