" taken from http://superuser.com/questions/697347/vim-how-to-treat-three-quotations-in-a-row-as-a-comment-rather-than-a-string
"
" Highlight docstrings as comments, not string.
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

hi def link pythonDocstring pythonComment
