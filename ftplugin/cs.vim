" OmniSharper
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

nnoremap <leader>rn :OmniSharpRename<cr>
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fm :OmniSharpFindMembers<cr>
nnoremap <leader>gd :OmniSharpGotoDefinition<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>

inoremap <C-n> <C-x><C-o>

command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
