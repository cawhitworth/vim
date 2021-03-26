let g:pathogen_disabled = []

if has("win32") || has("win16")
  call add(g:pathogen_disabled, "taglist")
  set grepprg=grep\ -nH
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

set cc=100         " Highlight column 100
set textwidth=100  " Wrap at column 100

set list
set listchars=tab:>·,trail:·,extends:»,precedes:«
                   " Show tabs, trailing spaces, and long lines

set hlsearch

set nomodeline      " Disable modelines
set modelines=0

if has("gui_running")
    set lines=30 columns=85
endif

set t_Co=256
set mouse=a

let mapleader=","


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

function! FindSlow(what, ext)
    " Save my sanity; probably a cleaner way to do this but whatever
    if &filetype == 'nerdtree'
        exec "wincmd l"
    endif

    exec "silent vimgrep " . a:what . " **/*" . a:ext
    exec "copen"
endfunction

function! FindExt()
    call inputsave()
    let what = input('Find: ')
    let ext = input('In (extension): ')
    call inputrestore()
    call FindSlow(what, ext)
endfunction

function! Find()
    call inputsave()
    let what = input('Find: ')
    call inputrestore()
    call FindFast(what)
endfunction

function! FindFast(what)
    " Save my sanity; probably a cleaner way to do this but whatever
    if &filetype == 'nerdtree'
        exec "wincmd l"
    endif

    exec "silent grep! --binary-files=without-match --exclude-dir=build --exclude-dir=oe-logs --exclude-dir=oe-workdir --exclude=tags -snR \"".a:what."\" ."
    exec "copen"
    exec "redraw!"
endfunction

function! FindCurrent()
    call FindFast(expand("<cword>"))
endfunction

command! DiffT NERDTreeClose | windo diffthis
command! DiffO windo diffoff | NERDTree

nnoremap <leader>dt :DiffT<CR>
nnoremap <leader>do :DiffO<CR>

nnoremap <leader>bs :w!<CR>:call Scons()<CR>
nnoremap <leader>bm :w!<CR>:call Make()<CR>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>

nnoremap <leader>t :!ctags -R<CR>

nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>. :CtrlPTag<CR>

nnoremap <leader>n :%s/<C-V><C-M>/\r/g<CR>

nnoremap <leader>ff :NERDTree<CR>
nnoremap <leader>fs :NERDTreeFind<CR>

nnoremap <leader>/ :call Find()<CR>
nnoremap <leader>e :call FindExt()<CR>
nnoremap <F12> :call FindCurrent()<CR>

nnoremap <leader>, :b#<CR>

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

nnoremap <leader>[ :bprev<CR>
nnoremap <leader>] :bnext<CR>

map <C-Right> :bnext<CR>
map <C-Left> :bprev<CR>


" Open NERDTree by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" Make highlighted text actually legible
hi Search ctermfg=black ctermbg=blue guifg=black guibg=blue
