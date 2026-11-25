set nocompatible
execute 'set runtimepath^=' . fnameescape(fnamemodify(expand('<sfile>:p'), ':h:h'))
let mapleader = ' '
runtime plugin/edk2_snippet.vim
new
setfiletype c
call assert_notequal('', maparg('<Leader>e', 'n'))
call setline(1, '    example')
call edk2_snippet#select(1)
call assert_equal(7, line('$'))
call assert_equal('      EFI_STATUS  Status = gBS->LocateProtocol (', getline(3))
call assert_equal('                                 &gXxxHandlerProtocolGuid, // IN EFI_GUID', getline(4))
call assert_equal('                                 NULL, // IN VOID   *Registration OPTIONAL', getline(5))
call assert_equal('                                 (VOID **)&Interface // OUT VOID', getline(6))
call assert_equal('                                 );', getline(7))
let before = getline(1, '$')
call edk2_snippet#select(0)
call assert_equal(before, getline(1, '$'))
enew!
nnoremap <buffer> <Leader>e :echo 'existing'<CR>
setfiletype cpp
call assert_match('existing', maparg('<Leader>e', 'n'))
enew!
let g:edk2_snippet_no_default_mapping = 1
setfiletype c
call assert_equal('', maparg('<Leader>e', 'n'))
if len(v:errors)
  call writefile(v:errors, 'tests/errors.log')
  cquit
endif
qa!


