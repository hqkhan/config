"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ripgrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>rg :Rg<SPACE>

if executable('rg')
    let g:rg_derive_root='true'
endif

