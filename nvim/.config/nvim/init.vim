call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}
Plug 'hqkhan/palenight' , {'branch': 'main'}
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons' " If you want to display icons, then use one of these plugins --lua
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'williamboman/nvim-lsp-installer'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'

call plug#end()

" General settings import
source ~/.config/nvim/settings.vim
luafile ~/.config/nvim/au_commands.lua

" Plugin config imports
source ~/.config/nvim/plug-config/fugitive.vim
source ~/.config/nvim/plug-config/undotree.vim
source ~/.config/nvim/plug-config/ripgrep.vim
luafile ~/.config/nvim/lua/config/nvim-tree.lua
luafile ~/.config/nvim/lua/config/galaxy-line.lua
luafile ~/.config/nvim/lua/config/treesitter.lua
luafile ~/.config/nvim/lua/config/fzf-lua.lua
luafile ~/.config/nvim/lua/config/bufferline.lua
luafile ~/.config/nvim/lua/config/indent-blankline.lua

" LSP 
luafile ~/.config/nvim/lua/config/lsp-installer.lua
luafile ~/.config/nvim/lua/config/lsp-config.lua
luafile ~/.config/nvim/lua/config/cmp-config.lua
luafile ~/.config/nvim/lua/config/dockerls.lua
luafile ~/.config/nvim/lua/config/python-ls.lua
luafile ~/.config/nvim/lua/config/rust_analyzer.lua
luafile ~/.config/nvim/lua/config/ccls.lua
luafile ~/.config/nvim/lua/config/lua-ls.lua

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('+termguicolors')
    let &t_8f="/<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="/<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup numbertoggle
  autocmd!
  autocmd BufWinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let g:lsp_diagnostics_enabled                = 0
let g:lsp_diagnostics_signs_enabled          = 0
let g:lsp_diagnostics_virtual_text_enabled   = 0
let g:lsp_diagnostics_highlights_enabled     = 0
let g:lsp_document_code_action_signs_enabled = 0

set background=dark
colorscheme palenight
