" Michal Kosinski
" started: 19/08/2009

version 7.0
syntax on
set nocompatible

" {{{ vundle config
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mkos/vim-config'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
call vundle#end()
filetype plugin indent on
" }}}

" {{{ general options

colorscheme monokai

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
set cursorline

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
set guifont     =Source\ Code\ Pro\ Medium\ 13 " set guifont=Droid\ Sans\ Mono\ 12
set guioptions -=T "no toolbar
set guioptions -=r "no scrollbar
set guioptions -=m "no menu

"}}}

" {{{ system specific options

" {{{ System(): set up system var for system specific config
function! System()
    if has("gui_running")
        if has("gui_gtk2")
            return "linux"
        elseif has("x11")
            return "x11"
        elseif has("gui_win32")
            return "windows"
        else
            return "unknown_cli"
        endif
    else
        return "console"
    endif
endf
" }}}

if System() == "console"
    colorscheme default
    set nocursorline
endif

if System() == "windows"
    cd ~
    let g:netrw_scp_cmd = '"c:\Program Files (x86)\PuTTY\pscp.exe" -q'
    set clipboard =unnamed
    "set guifont   =Consolas:h12:cEASTEUROPE
    set guifont =Source\ Code\ Pro:h11:cEASTEUROPE
    winsize 120 40
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
" tab/s-tab on block means indent/unindent block
vmap <tab> >gv
vmap <S-tab> <gv

"}}}

" {{{ file type spcific autocommands

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

" Scala
autocmd BufRead,BufNewFile *.scala set ft=scala

" markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set wrap

" makefile
autocmd BufRead,BufNewFile *.mk,Makefile set noexpandtab

" vim
autocmd BufRead,BufNewFile *.vim,.vimrc set fdm=marker 

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
"vim:fdm=marker
