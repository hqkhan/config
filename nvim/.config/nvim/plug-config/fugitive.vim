"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gs :G<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gp :Git -c push.default=current push<CR>
nmap <leader>gw :Gwrite!<CR>
nmap <leader>dg :diffget<CR> 
nmap <leader>dp :diffput<CR> 
" nmap <leader>co :G branch --all<CR><bar>:Git checkout 

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gm :Gvdiffsplit!<CR>
nmap <leader>gl :diffget //3<CR>:diffupdate<CR>
nmap <leader>gh :diffget //2<CR>:diffupdate<CR>
