" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
"
" Based on gobo colorscheme by Otávio Corrêa Cordeiro
" Maintainer: Michal Kosinski
" Created: 2013-09-26


set background=light

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "bishop"  

hi normal       guifg=#111111   guibg=#ffffff   gui=none 
hi comment      guifg=#33cc99   guibg=#ffffff   gui=none  
hi constant     guifg=#cc0099   guibg=#ffffff   gui=none  
hi statement    guifg=#0066ff   guibg=#ffffff   gui=none  
hi preproc      guifg=#ff001e   guibg=#ffffff   gui=none
hi type         guifg=#6600cc   guibg=#ffffff   gui=none
hi special      guifg=#6600cc   guibg=#ffffff   gui=none
hi operator     guifg=#cc0099   guibg=#ffffff   gui=none

hi linenr       guifg=#111111   guibg=#ffffff   gui=none
hi cursorline                   guibg=#f6edff   gui=none
hi cursorlinenr guifg=#cc0099                   gui=bold
hi cursor       guifg=#ffffff   guibg=#a667e6   gui=none
hi cursorim     guifg=#ffffff   guibg=#111111   gui=none

hi statusline   guifg=#ffffff   guibg=#a667e6   gui=none
hi user1        guifg=#ffffff   guibg=#a667e6   gui=bold
hi user2        guifg=#ffffff   guibg=#a667e6   gui=bold
hi search                       guibg=#b9f500   gui=none
hi visual       guifg=#ffffff   guibg=#0066ff   gui=none
hi matchparen   guifg=#ffffff   guibg=#33cc99   gui=none

hi markdownBold                                 gui=bold
hi markdownItalic                               gui=italic
hi markdownBoldItalic                           gui=bold,italic
hi! link incsearch search
