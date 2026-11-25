set nocompatible
execute 'set runtimepath^=' . fnameescape(fnamemodify(expand('<sfile>:p'), ':h:h'))
let mapleader = ' '
runtime plugin/edk2_snippet.vim
new
setfiletype text
call assert_notequal('', maparg('<Leader>e', 'n'))
call setline(1, '    example')
call edk2_snippet#select(1)
call assert_equal(15, line('$'))
call assert_equal('      // Ref: https://uefi.org/specs/UEFI/2.11/07_Services_Boot_Services.html#efi-boot-services-locateprotocol', getline(2))
call assert_equal('      EFI_STATUS               Status;', getline(3))
call assert_equal('      EFI_ACPI_TABLE_PROTOCOL  *AcpiTable;', getline(4))
call assert_equal('    ', getline(5))
call assert_equal('      Status = gBS->LocateProtocol (', getline(6))
call assert_equal('                      &gEfiAcpiTableProtocolGuid,', getline(7))
call assert_equal('                      NULL,', getline(8))
call assert_equal('                      (VOID **)&AcpiTable', getline(9))
call assert_equal('                      );', getline(10))
call assert_equal('      if (EFI_ERROR (Status)) {', getline(11))
call assert_equal('        return Status;', getline(12))
call assert_equal('      }', getline(13))
call assert_equal('    ', getline(14))
call assert_equal('      // Use AcpiTable->InstallAcpiTable (...) as needed.', getline(15))
let before = getline(1, '$')
call edk2_snippet#select(0)
call assert_equal(before, getline(1, '$'))
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


