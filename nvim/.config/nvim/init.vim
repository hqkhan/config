call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'marko-cerovac/material.nvim'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons' " If you want to display icons, then use one of these plugins --lua
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

" General settings import
source ~/.config/nvim/settings.vim

" Plugin config imports
source ~/.config/nvim/plug-config/fugitive.vim
source ~/.config/nvim/plug-config/undotree.vim
source ~/.config/nvim/plug-config/ripgrep.vim
source ~/.config/nvim/plug-config/nvim-tree.vim
luafile ~/.config/nvim/lua/config/galaxy-line.lua
luafile ~/.config/nvim/lua/config/treesitter.lua
luafile ~/.config/nvim/lua/config/fzf-lua.lua

" LSP 
source ~/.config/nvim/plug-config/lsp-config.vim
luafile ~/.config/nvim/lua/config/compe-config.lua
luafile ~/.config/nvim/lua/config/dockerls.lua
luafile ~/.config/nvim/lua/config/python-ls.lua
luafile ~/.config/nvim/lua/config/lua-ls.lua

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

nnoremap <leader>yy "+y

let g:lsp_diagnostics_enabled                = 0
let g:lsp_diagnostics_signs_enabled          = 0
let g:lsp_diagnostics_virtual_text_enabled   = 0
let g:lsp_diagnostics_highlights_enabled     = 0
let g:lsp_document_code_action_signs_enabled = 0

set background=dark
colorscheme palenight
