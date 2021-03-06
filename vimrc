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
"Plugin 'tpope/vim-fugitive'
Plugin 'mkos/vim-config'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'tomasr/molokai'
Plugin 'sjl/badwolf'
Plugin 'vim-voom/voom'
Plugin 'townk/vim-autoclose'
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
set laststatus  =2                              "always show statusline
set backspace   =indent,eol,start               " backspace props
set shortmess  +=I                              " do not show welcome screen
set fileformat  =unix                           " set line ending to \n 
set listchars   =tab:>-,trail:-,nbsp:%,eol:$    " for :set list
set clipboard   =unnamedplus                    " use unnamed buffer to copy & paste
set ssop        =buffers,curdir,folds

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
        elseif has("mac")
            return "osx"
        else
            return "unknown_cli"
        endif
    else
        return "console"
    endif
endf
" }}}

if System() == "linux"
    set guifont     =Source\ Code\ Pro\ Medium\ 13 " set guifont=Droid\ Sans\ Mono\ 12
    set guioptions -=T "no toolbar
    set guioptions -=r "no scrollbar
    set guioptions -=m "no menu
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
endif

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
    set guioptions -=T "no toolbar
    set guioptions -=r "no scrollbar
    set guioptions -=m "no menu
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc
    winsize 120 40
endif

if System() == "osx"
    set guifont =Menlo\ Regular:h12
    set clipboard =unnamed
    set guioptions -=T "no toolbar
    set guioptions -=r "no scrollbar
    set guioptions -=m "no menu
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc
    set transparency=12
    winsize 150 50
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
" change working directory of current buffer to current file's dir
" based on: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nmap <leader>cd :lcd %:p:h<cr>:pwd<cr>
nmap <silent> <leader>rc :source $MYVIMRC<cr>:echo 'Config reloaded!'<cr>
" remove search highlighting
nmap <leader>n :noh<cr>
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

" voom
autocmd FileType voomtree set foldlevel=5

" }}}

" {{{ plugin configuration

" ctrl-p
let g:ctrlp_working_path_mode = 'ra'    " specifies ctrlP working dir: r - VCS mode, a - other dirs
let g:ctrlp_cmd = 'CtrlPBuffer'         " <c-p> always start in buffer mode
let g:ctrlp_by_filename = 0             " search by filename by default
let g:ctrlp_show_hidden = 1             " show hidden files
let g:ctrlp_open_new_file = 'r'         " open newly created file in the same window <c-y>
let g:ctrlp_open_multiple_files = 'ij'  " open  multiple files with <c-o> in hidden buffers jumping to the first one
let g:ctrlp_prompt_mappings = { 
    \ 'ToggleType(1)': ['<c-p>', '<c-up>'],
    \ 'PrtHistory(1)': ['<c-f>']
    \}                              " subsequent <c-p>s switch mode
" taken from http://stackoverflow.com/questions/21346068/slow-performance-on-ctrlp-it-doesnt-work-to-ignore-some-folders
" to fix slowness of caching. Requires installed ag (a.k.a The Silver Searcher https://github.com/ggreer/the_silver_searcher)
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" commentary
au FileType python,sh set commentstring=#\ %s
au FileType c,java    set commentstring=//\ %s
au FileType vim       set commentstring=\"\ %s

" NERDTree
let NERDTreeMinimalUI = 1 " do not show help and bookmarks messages
let NERDTreeRespectWildIgnore = 1 " use wildignore setting to filter out files
map <f2> :NERDTreeToggle<cr>
" close vim if only nerd tree is open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Voom
let g:voom_ft_modes={'markdown': 'markdown'}
let g:voom_default_mode='markdown'

" }}}
"vim:fdm=marker
