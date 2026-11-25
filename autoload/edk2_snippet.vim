function! edk2_snippet#setup() abort
  nnoremap <silent> <buffer> <Plug>(edk2-snippet-menu) :call edk2_snippet#menu()<CR>
  if get(g:, 'edk2_snippet_no_default_mapping', 0)
    return
  endif
  let l:key = get(g:, 'edk2_snippet_mapping', '<Leader>e')
  if !empty(l:key) && empty(maparg(l:key, 'n')) && !hasmapto('<Plug>(edk2-snippet-menu)', 'n')
    execute 'nmap <silent> <buffer> ' . l:key . ' <Plug>(edk2-snippet-menu)'
  endif
endfunction

function! edk2_snippet#menu() abort
  let l:choice = inputlist(['EDK2 snippets:', '1. LocateProtocol', '0. Cancel'])
  call edk2_snippet#select(l:choice)
endfunction

function! edk2_snippet#select(choice) abort
  if a:choice == 1
    call edk2_snippet#insert_locate_protocol()
  endif
endfunction

function! edk2_snippet#insert_locate_protocol() abort
  let l:indent = matchstr(getline('.'), '^\s*')
  let l:lines = [
        \ '  // Ref: https://uefi.org/specs/UEFI/2.11/07_Services_Boot_Services.html#efi-boot-services-locateprotocol',
        \ '  EFI_STATUS  Status = gBS->LocateProtocol (',
        \ '                             &gXxxHandlerProtocolGuid, // IN EFI_GUID',
        \ '                             NULL, // IN VOID   *Registration OPTIONAL',
        \ '                             (VOID **)&Interface // OUT VOID',
        \ '                             );',
        \ ]
  call append(line('.'), map(l:lines, 'l:indent . v:val'))
endfunction

