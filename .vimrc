
" ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
" ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
" ██║   ██║██║██╔████╔██║██████╔╝██║
" ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"  ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"   ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝


" Using Vundle to manage plugins
" =============================
set 		nocompatible         " be iMproved, required for Vundle
filetype 	off                  " required for Vundle
set 		rtp+=~/.vim/bundle/Vundle.vim
call 		vundle#begin()
Plugin 		'VundleVim/Vundle.vim'
Plugin 		'vim-airline/vim-airline'
Plugin 		'vim-airline/vim-airline-themes'
Plugin 		'airblade/vim-gitgutter'
Plugin 		'rafi/awesome-vim-colorschemes'
Plugin 		'ntk148v/vim-horizon'
Plugin 		'tpope/vim-fugitive'
Plugin 		'maralla/completor.vim'
Plugin 		'alvan/vim-closetag'
call 		vundle#end()        " required for Vundle
filetype 	plugin indent on    " required for Vundle
" =============================

" vim-airline and interface configuration
" ============================
let 		g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let 		g:airline_skip_empty_sections = 1
let			g:airline#extensions#tabline#enabled = 1
let 		g:airline#extensions#tabline#left_sep = ' '
let	 		g:airline#extensions#tabline#left_alt_sep = '|'
let 		g:airline#extensions#tabline#formatter = 'default'
let 		g:airline_theme='molokai'
let 		g:airline#extensions#tabline#buffer_nr_show = 1

"color solarized8_high
color 		afterglow
set		 	laststatus=2
set 		ttimeoutlen=50

" ============================

set 		autoindent
set			encoding=UTF-8
set 		tabstop=4
set 		shiftwidth=4
set 		shortmess=F
syntax 		enable

" Auto deletes all trailing whitespaces on save
autocmd 	BufWritePre * %s/\s\+$//e

" Better command-line completion
set 		wildmenu

" Enable use of the mouse for all modes
set 		mouse=a

" Stop certain movements from always going to the first character of a line.
set 		nostartofline

" Show partial commands in the last line of the screen
set 		showcmd

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set 		confirm

" Allow backspacing over autoindent, line breaks and start of insert action
set 		backspace=indent,eol,start

" Alt + number to navigation between buffers
nnoremap 	<Leader>1 :1b<CR>
nnoremap 	<Leader>2 :2b<CR>
nnoremap 	<Leader>3 :3b<CR>
nnoremap 	<Leader>4 :4b<CR>
nnoremap 	<Leader>5 :5b<CR>
nnoremap 	<Leader>6 :6b<CR>
nnoremap 	<Leader>7 :7b<CR>
nnoremap 	<Leader>8 :8b<CR>
nnoremap 	<Leader>9 :9b<CR>
nnoremap 	<Leader>0 :10b<CR>

" Lines numeration
set 		number relativenumber

" Allows to ctrl+ru_sym
set 		langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" case insensitive searching
set 		ignorecase

" case-sensitive if expresson contains a capital letter
set 		smartcase
set 		hlsearch

" set incremental search, like modern browsers
set 		incsearch

" Show matching braces
set 		showmatch

" Display the cursor position on the last line of the screen or in the status line of a window
set 		ruler

" Split open at the bottom and right
set 		splitright

" Space to start insert mode
:nnoremap 	<Space> i


" ctrl+something but it's shift+
" Shift+f - search
map			<S-F>  /

" Shift+q - quit
map 		<S-q> :q

" Shift+s - save
map 		<S-s> :w<CR><Esc>

" Shift+w - save&quit
map 		<S-w> :x<CR><Esc>

" Ctrl+l to remove search hihglighting
nnoremap 	<silent> <C-L> :nohlsearch<CR><C-L>

" Shift+tab to move text to left
inoremap 	<S-Tab> <C-d>

" Ctrl +e equals End, ctrl+w equals home in insert mode
inoremap 	<C-e> <End>
inoremap 	<C-w> <Home>

" Requires gvim
" Ctrl+C, Ctrl+v, Ctrl+x, Ctrl+a, Ctrl+z, Ctrl+d +  system-buffer
vnoremap 	<C-c> "*y :let @+=@*<CR>:echo "Copied!"<CR>
vnoremap 	<C-x> "*x :let @+=@*<CR>:echo "Cutted!"<CR>
map 		<C-v> "+p
nnoremap 	<C-A> ggVG
map 		<C-z> u
inoremap 	<C-z> <Esc>ui
inoremap 	<C-d> <Esc>yypi

" Ctrl + backspace to delete all symbols till start of word
"	inoremap <C-BS> <Esc>dbi
"	nnoremap <M-BS> db

" Ctrl + up or down move screen instead of cursor
inoremap 	<C-Up> <Esc><C-y>li
nnoremap 	<C-Up> <C-y>

inoremap 	<C-Down> <Esc><C-e>li
nnoremap 	<C-Down> <C-e>

" shift + arrows in insert mode to select something
inoremap 	<s-left> <esc>v<left>
vnoremap 	<s-left> <c-left>

inoremap 	<s-up> <esc>v<up>
vnoremap 	<s-up> <up>

inoremap	<s-down> <esc>v<down>
vnoremap 	<s-down> <down>

inoremap 	<s-right> <esc>v<right>
vnoremap 	<s-right> <c-right>

" alt + arrow to navigate between splits
map 		<m-left> <c-w><left>
map 		<m-up> <c-w><up>
map 		<m-down> <c-w><down>
map 		<m-right> <c-w><right>

" shift + arrows to resize splits
nnoremap 	<S-Down> <C-w>+
nnoremap 	<S-Up> <C-w>-
nnoremap 	<S-Left> <C-w><
nnoremap 	<S-Right> <C-w>>


" NERDtree
"map <C-n> 	:NERDTreeToggle<CR>
"set timeout
set 		timeoutlen=1000
"set ttimeout
set 		ttimeoutlen=50


" NERD tree autoload and auto close if that's the only window opened
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

