func GoDef()
  normal m'
  :TSDef
endfunc

nnoremap <silent><buffer> K :TSType<CR>
nnoremap <silent><buffer> gd :call GoDef()<CR>
nnoremap <silent><buffer> <leader>r :TSRefs<CR>
nnoremap <silent><buffer> <F2> :TSRename<CR>
