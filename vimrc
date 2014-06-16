execute pathogen#infect()

colo desert
syn on

filetype plugin indent on
runtime macros/matchit.vim

au BufRead,BufNewFile *.md set filetype=markdown

set encoding=utf-8

set nowrap         " Don't wrap

set tabstop=4      " Indenting 4 chars, soft-tabs
set shiftwidth=4
set smartindent
set expandtab

set backspace=indent,eol,start
                   " Make backspace work nearly everywhere

set number         " Line numbers FTW
set showmatch      " Show matching brackets
set incsearch      " Search-as-you-type

set cc=80          " Highlight column 80

set list
set listchars=tab:>·,trail:·,extends:»,precedes:«
                   " Show tabs, trailing spaces, and long lines

set hlsearch

if has("gui_running")
    set lines=30 columns=85
endif

let mapleader=","

nnoremap <leader>l :TlistOpen<CR>
nnoremap <leader>, :b#<CR>

function! UnitTestPython()

    let tests = system("C:\\cygwin\\bin\\grep -Rl --include=*.py unittest.main .")
    let testscript = substitute(tests, '\.py\(.\+\)', '.py', 'g')

    let results = system("python " . testscript)

    let winnum = bufwinnr('__UnitTestResults__')
    if winnum != -1
        if winnr() != winnum
            exec winnum . "wincmd w"
        endif
    else
        belowright split __UnitTestResults__
        setlocal buftype=nofile
        resize 15
    endif

    normal! ggdG
    call append(0, split(results, '\v\n'))
endfunction

nnoremap <leader>[ :w!<CR>:call UnitTestPython()<CR>

nnoremap <leader>/ :!ctags -R<CR>

nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>. :CtrlPTag<CR>



" Status line
set noruler
set laststatus=2
set statusline=
set statusline+=%<\ %n:%f\ %m  " Buffer, filename, modified
set statusline+=%y             " Filetype
set statusline+=%=             " split
set statusline+=%l/%L          " line/Length
set statusline+=\ @\ %c\ (%P)
hi StatusLine guifg=LightGray guibg=DarkGray ctermfg=7 ctermbg=8

au BufRead,BufNewFile *.il setfiletype ilasm
