" Michal Kosinski
" started: 19/08/2009

version 7.0
syntax on

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mkos/vim-config'
call vundle#end()
filetype plugin indent on

" {{{ general options
set nocompatible
set showmode    " show mode on the last line
set ruler       " show statusline
set number
set expandtab
set smarttab
set autoread    "always read changes made to file outside vim
set autowrite   "always write while switching buffers
set nowrap
set autoindent
set incsearch
set hlsearch    "highlight actual search
set wildmenu    "show options in menu while completing
set linebreak   "breaks at word boundaries rather than in a middle of a word
set ignorecase
set smartcase   "works with ignorecase and overrides it's value if the search pattern contains upper case letters

set tabstop     =4
set shiftwidth  =4
set encoding    =utf-8
set laststatus  =2 "always show statusline
set backspace   =indent,eol,start "backspace props
set shortmess  +=I "do not show welcome screen
set filetype    =unix
set listchars   =tab:>-,trail:-,nbsp:%,eol:$    " for :set list
set clipboard   =unnamedplus  " use unnamed buffer to copy & paste
set ssop        =buffers,curdir,folds
"}}}

" {{{ gui/console specific options
if has("gui_running")
    """" gui specific options

    colorscheme ir_black

    set guioptions -=T "no toolbar
    set guioptions -=r "no scrollbar
    set guioptions -=m "no menu
    set cursorline
    set lines=40 columns=110

    " {{{ font configuration
    if has("gui_gtk2")
        " set guifont=Droid\ Sans\ Mono\ 12
        set guifont=Source\ Code\ Pro\ Medium\ 13
    elseif has("x11")
        " Also for GTK 1
        set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_win32")
        set guifont=Consolas:h11:cEASTEUROPE
    endif
    " {{{ statusline setup

    set stl=                                  " clear variable
    set stl+=%02.2n\                          " buffer number
    if v:version >= 600
        set stl+=%{strlen(&ft)?&ft:'none'}:   " filetype
        set stl+=%{&encoding}:                " encoding
    endif
    set stl+=%{&fileformat}\                  " file format
    set stl+=%1*%F%*\                              " file name
    "set stl+=cwd:\ %1*%{getcwd()}%*                " current working dir
    set stl+=[%M%R]                           " flag
    set stl+=%=                                    " right align
    set stl+=[%2*%{Mode()}%*]                      " mode
    set stl+=%14.((%l,%c)%)\ %<%P " offset
    " }}}
else
    """" console specific options
    colorscheme default
endif
" }}}

" {{{ key bindings
let mapleader=","

" make html out of markdown
nmap <silent> <leader>md :silent !$HOME/repos/scripts/mdnotes %<cr>
" load last saved session
nmap <silent> <leader>sl :so $HOME/.session.vim<cr>
" close buffer
nmap <silent> <leader>q :bd<cr>
"}}}
" {{{ file type specific autocommands

" Sessions
"autocmd VimEnter * silent so $HOME/.session.vim
autocmd VimLeave * mksession! $HOME/.session.vim

" C, C++ specific
autocmd BufRead,BufNewFile *.c,*.cc,*.cpp,*.h set cindent

" Octave
autocmd BufRead,BufNewFile *.m,*.oct set cindent
autocmd BufRead,BufNewFile *.m,*.oct set ft=octave

" Java
autocmd BufRead,BufNewFile *.java set smartindent
autocmd BufRead *.java set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
autocmd BufRead *.java set makeprg=ant\ -find\ build.xml

" markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set wrap

" makefile
autocmd BufRead,BufNewFile *.mk,Makefile set noexpandtab

" }}}
" {{{ plugin configuration

" ctrl-p
let g:ctrlp_cmd = 'CtrlPBuffer'     " <c-p> always start in buffer mode
let g:ctrlp_by_filename = 0         " search by filename by default
let g:ctrlp_show_hidden = 1         " show hidden files
let g:ctrlp_open_new_file = 'r'     " open newly created file in the same window <c-y>
let g:ctrlp_open_multiple_files = 'ij'  " open  multiple files with <c-o> in hidden buffers jumping to the first one
let g:ctrlp_prompt_mappings = { 
    \ 'ToggleType(1)': ['<c-p>', '<c-up>'],
    \ 'PrtHistory(1)': ['<c-f>']
    \}                              " subsequent <c-p>s switch mode

" commentary
au FileType python,sh set commentstring=#\ %s
au FileType c,java    set commentstring=//\ %s
au FileType vim       set commentstring=\"\ %s

" }}}
" {{{ Mode(): helper for the statusline

function! Mode()
    if mode() == 'i'
        return 'INSERT'
    elseif mode() == 'n'
        return 'NORMAL'
    elseif mode() == 's' || mode() == 'S' || mode() == 'CTRL-S'
        return 'SELECT'
    elseif mode() == 'v' || mode() == 'V' || mode() == 'CTRL-V'
        return 'VISUAL'
    elseif mode() == 'R' || mode() == 'Rv'
        return 'REPLCE'
    elseif mode() == 'c'    " command line
        return 'CMDLIN'
    elseif mode() == 'r'    " hit enter prompt
        return 'HENTER'
    elseif mode() == 'rm'   " prompt to hit for more
        return '-MORE-'
    elseif mode() == 'r?'   " query requiring confirmation
        return 'CONFRM'
    elseif mode() == '!'    " shell execute
        return 'SHELLX'
    elseif mode() == 'no'   " operator pending
        return 'OPPEND'
    elseif mode() == 'cv' || mode() == 'ce'     " ex mode
        return 'EXMODE'
    else
        return '!WTF?!'     " wtf?
    endif
endf
" }}}

"vim:fdm=marker
