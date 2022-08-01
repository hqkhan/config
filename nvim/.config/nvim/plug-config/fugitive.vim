"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git -c push.default=current push<CR>
nnoremap <leader>gw :Gwrite!<CR>
" # Get commit hash from fzf lua
nnoremap <leader>ge :Gedit HEAD~:%<Left><Left>

nnoremap <leader>dg :diffget<CR> 
nnoremap <leader>dp :diffput<CR> 
" nnoremap <leader>co :G branch --all<CR><bar>:Git checkout 

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gm :Gvdiffsplit!<CR>
nnoremap <leader>gl :diffget //3<CR>:diffupdate<CR>
nnoremap <leader>gh :diffget //2<CR>:diffupdate<CR>
