call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons' " If you want to display icons, then use one of these plugins --lua
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'ibhagwan/smartyank.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind-nvim'

call plug#end()

" General settings import
source ~/.config/nvim/settings.vim
luafile ~/.config/nvim/lua/au_commands.lua

" Plugin config imports
source ~/.config/nvim/plug-config/fugitive.vim
luafile ~/.config/nvim/lua/plugins/nvim-tree.lua
luafile ~/.config/nvim/lua/plugins/galaxy-line.lua
luafile ~/.config/nvim/lua/plugins/treesitter.lua
luafile ~/.config/nvim/lua/plugins/fzf-lua/init.lua
luafile ~/.config/nvim/lua/plugins/fzf-lua/mappings.lua
luafile ~/.config/nvim/lua/plugins/bufferline.lua
luafile ~/.config/nvim/lua/plugins/devicons.lua
luafile ~/.config/nvim/lua/plugins/indent.lua
luafile ~/.config/nvim/lua/plugins/smartyank.lua

" LSP 
luafile ~/.config/nvim/lua/plugins/lsp-installer.lua
luafile ~/.config/nvim/lua/plugins/lsp-config.lua
luafile ~/.config/nvim/lua/plugins/cmp-config.lua

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colorscheme 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if exists('+termguicolors')
"     let &t_8f="/<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b="/<Esc>[48;2;%lu;%lu;%lum"
"     set termguicolors
" endif

" set t_Co=256
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup numbertoggle
  autocmd!
  autocmd BufWinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set background=dark
lua vim.g.lua_embark_transparent = true
colorscheme lua-embark

