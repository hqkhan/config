source $HOME/.config/settings/settings.vim
source $HOME/.config/settings/plugin_settings.vim

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
call plug#end()

augroup numbertoggle
  autocmd!
  autocmd BufWinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end"

map <silent> "=p :r !powershell.exe -Command Get-Clipboard<CR>

" Quick sourcing of init.vim
nnoremap <leader>ss :source ~/.config/nvim/init.vim<CR>

