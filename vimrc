colo desert
syn on

filetype plugin on
runtime macros/matchit.vim

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

if has("gui_running")
    set lines=30 columns=85
endif

set noruler
set laststatus=2
set statusline=
set statusline+=%<\ %n:%f\ %m  " Buffer, filename, modified
set statusline+=%y             " Filetype
set statusline+=%=             " split
set statusline+=%l/%L          " line/Length
set statusline+=\ @\ %c\ (%P)
hi StatusLine guifg=LightGray guibg=DarkGray ctermfg=7 ctermbg=8
