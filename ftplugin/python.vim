function! UnitTestPython()

    let tests = system("grep -Rl --include=*.py unittest.main .")
    let testscript = substitute(tests, '\.py\(.\+\)', '.py', 'g')

    let results = system("python " . testscript)

    call BuildOutput(results)
endfunction

function! RunPython(file)
    let results = system("python " . a:file)
    call BuildOutput(results)
endfunction

nnoremap <leader>rx :w!<CR>:call RunPython(expand("%"))<CR>
nnoremap <leader>rr :w!<CR>:pyfile %<CR>
nnoremap <leader>t :w!<CR>:call UnitTestPython()<CR>

