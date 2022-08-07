"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gs <Esc>:G<CR>
nnoremap <leader>gc <Esc>:Git commit<CR>
nnoremap <leader>gp <Esc>:Git -c push.default=current push<CR>
nnoremap <leader>gw <Esc>:Gwrite!<CR>
" # Get commit hash from fzf lua
nnoremap <leader>ge <Esc>:vsp<CR>:Gedit HEAD~:%<Left><Left>

nnoremap <leader>dg <Esc>:diffget<CR> 
nnoremap <leader>dp <Esc>:diffput<CR> 
" nnoremap <leader>co :G branch --all<CR><bar>:Git checkout 

nnoremap <leader>gd <Esc>:Gvdiff<CR>
nnoremap <leader>gm <Esc>:Gvdiffsplit!<CR>
nnoremap <leader>gl <Esc>:diffget //3<CR>:diffupdate<CR>
nnoremap <leader>gh <Esc>:diffget //2<CR>:diffupdate<CR>
