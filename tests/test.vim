set nocompatible
execute 'set runtimepath^=' . fnameescape(fnamemodify(expand('<sfile>:p'), ':h:h'))
let mapleader = ' '
runtime plugin/edk2_snippet.vim
new
setfiletype text
call assert_notequal('', maparg('<Leader>e', 'n'))
let names = ['LocateProtocol', 'LocateHandle', 'LocateHandleBuffer', 'LocateDevicePath', 'HandleProtocol', 'OpenProtocol', 'CloseProtocol', 'InstallProtocolInterface', 'ReinstallProtocolInterface', 'UninstallProtocolInterface', 'InstallMultipleProtocolInterfaces', 'UninstallMultipleProtocolInterfaces', 'RegisterProtocolNotify', 'ProtocolsPerHandle', 'OpenProtocolInformation', 'CreateEvent', 'CreateEventEx', 'CloseEvent', 'SignalEvent', 'WaitForEvent', 'CheckEvent', 'SetTimer', 'RaiseTPL', 'RestoreTPL']
for index in range(len(names))
  silent %delete _
  call setline(1, '    example')
  call cursor(1, 5)
  call edk2_snippet#select(index + 1)
  call assert_equal('    example', getline(1))
  let lines = getline(2, '$')
  call assert_equal('    // Ref: https://uefi.org/specs/UEFI/2.11/07_Services_Boot_Services.html#efi-boot-services-' . tolower(names[index]), lines[0])
  call assert_match('^    // brief: .\+', lines[1])
  call assert_match('gBS->' . names[index] . ' (', join(lines, "\n"))
  call assert_true(len(filter(copy(lines), 'v:val !~# "^    "')) == 0, names[index] . ' indentation')
  if index([1, 2, 13, 14], index) >= 0
    call assert_match('FreePool (', join(lines, "\n"))
  endif
  if index([10, 11], index) >= 0
    call assert_match('NULL\_s*);', join(lines, "\n"))
  endif
  if index >= 15 && index <= 21
    call assert_match('gBS->CloseEvent (Event)', join(lines, "\n"))
  endif
  if index >= 19 && index <= 21
    call assert_match('TimerRelative, 10000000ULL', join(lines, "\n"))
  endif
  if index >= 22
    call assert_match('gBS->RaiseTPL (TPL_NOTIFY)', join(lines, "\n"))
    call assert_match('gBS->RestoreTPL (OldTpl)', join(lines, "\n"))
  endif
endfor
silent %delete _
call setline(1, '    example')
call cursor(1, 5)
call edk2_snippet#select(1)
call assert_match('Status = EFI_NOT_STARTED;', getline(4))
let before = getline(1, '$')
for choice in [0, -1, 25, 999]
  call edk2_snippet#select(choice)
  call assert_equal(before, getline(1, '$'))
endfor
silent %delete _
call setline(1, 'abcXYZ')
call cursor(1, 4)
call edk2_snippet#select(1)
call assert_equal('abcXYZ', getline(1))
call assert_match('^   // Ref:', getline(2))
call assert_match('^   // brief:', getline(3))
silent %delete _
call setline(1, '')
call edk2_snippet#select(1)
call assert_equal('', getline(1))
call assert_match('^// Ref:', getline(2))
call assert_match('^// brief:', getline(3))
enew!
nnoremap <buffer> <Leader>e :echo 'existing'<CR>
setfiletype cpp
call assert_match('existing', maparg('<Leader>e', 'n'))
let g:edk2_snippet_no_default_mapping = 1
enew!
setfiletype text
call assert_equal('', maparg('<Leader>e', 'n'))
if len(v:errors)
  call writefile(v:errors, 'tests/errors.log')
  cquit
endif
qa!
