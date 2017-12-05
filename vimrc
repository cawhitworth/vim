let g:pathogen_disabled = []

if has("win32") || has("win16")
  call add(g:pathogen_disabled, "taglist")
endif

execute pathogen#infect()

colo desert
syn on

filetype plugin indent on
runtime macros/matchit.vim

au BufRead,BufNewFile *.md set filetype=markdown

set encoding=utf-8

set wrap           " Wrap

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

set t_Co=256
set mouse=a

let mapleader=","

nnoremap <leader>l :TlistOpen<CR>
nnoremap <leader>, :b#<CR>

function! BuildOutput(output)
    let winnum = bufwinnr('BUILD')
    if winnum != -1
        if winnr() != winnum
            exec winnum . "wincmd w"
        endif
    else
        belowright split BUILD
        setlocal buftype=nofile
        resize 15
    endif

    normal! ggdG
    call append(0, split(a:output, '\v\n'))
endfunction

function! Make()
    let make = system("make clean ; make all")
    call BuildOutput(make)
endfunction

function! Scons()
    let scones = system("scons")
    call BuildOutput(scones)
endfunction

function! Find(what, ext)
    exec "vimgrep " . a:what . " **/*" . a:ext
    exec "copen"
endfunction

function! FindInteractive()
    call inputsave()
    let what = input('Find: ')
    let ext = input('In (extension): ')
    call inputrestore()
    call Find(what, ext)
endfunction

nnoremap <leader>bs :w!<CR>:call Scons()<CR>
nnoremap <leader>bm :w!<CR>:call Make()<CR>

nnoremap <leader>t :!ctags -R<CR>

nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>. :CtrlPTag<CR>

nnoremap <leader>n :%s/<C-V><C-M>/\r/g<CR>

nnoremap <leader>f :NERDTree<CR>

nnoremap <leader>/ :call FindInteractive()<CR>

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
