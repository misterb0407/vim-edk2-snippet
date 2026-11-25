if exists('g:loaded_edk2_snippet')
  finish
endif
let g:loaded_edk2_snippet = 1

augroup edk2_snippet
  autocmd!
  autocmd FileType c,cpp call edk2_snippet#setup()
augroup END
