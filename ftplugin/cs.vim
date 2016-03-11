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

function! MSBuild(platform)
    let command = "msbuild /property:platform=\"". a:platform . "\""
    let results = system(command)
    call BuildOutput(command . "\r\n" . results)
endfunction

function! CSC()
    let command = "csc " . expand("%")
    let results = system(command)
    call BuildOutput(command . "\r\n" . results)
endfunction

nnoremap <leader>bx :w!<CR>:call MSBuild("x86")<CR>
nnoremap <leader>b6 :w!<CR>:call MSBuild("x64")<CR>
nnoremap <leader>ba :w!<CR>:call MSBuild("Any CPU")<CR>

nnoremap <leader>bc :w!<CR>:call CSC()<CR>
