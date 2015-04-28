call pathogen#infect()
filetype plugin indent on

syntax on
set autochdir
set noswapfile
set bg=dark
colorscheme molokai_mod
set t_Co=256
"set mouse=a

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set noeb vb t_vb= 	 " disable beep and flash 

"set number
set ignorecase
set incsearch
set hlsearch
set showmatch
let Tlist_Use_Right_Window = 1
set matchpairs=(:),{:},[:],<:>
imap <C-BS> <C-W>
"imap <C-Del> <Esc>dwi<CR>
imap <C-Del> <C-O>dw
set pastetoggle=<F2>
" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Enable the feature, don't forget :set modelines=xx
set modeline

" Check the first five lines in a file for vim:vim
set modelines=5

"autocmd BufNewFile *.java
"  \ exe "normal Opublic class " . expand('%:t:r') . "\n{\n}\<Esc>1G"

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Systemd
au BufRead,BufNewFile *.service set filetype=cfg
au BufRead,BufNewFile *.target set filetype=cfg

" HTML
au BufRead,BufNewFile *.html5 set filetype=html
au BufRead,BufNewFile *.xhtml set filetype=html

" JavaScript
"au BufRead,BufNewFile *.coffee set filetype=javascript

" Substitute the new file. :)
autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge

" Fix for E492 :W :Q are now working.
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

command SaveAsRoot :w !sudo tee % > /dev/null
cmap w!! w !sudo tee > /dev/null %

command SaveAsRootAndSetChmodX :w !sudo tee % && sudo chmod +x % > /dev/null
cmap w!x w !sudo tee % && sudo chmod +x % > /dev/null %
