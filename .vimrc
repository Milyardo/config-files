"==========================
"Vim UI Options
"==========================
syntax on						"Turn on Syntax Highlighting
set number						"Turn on Line Numbering
set nowrap 						"No line wrapping
set ruler						"Set cursor position in vim status line
set hls							"Highlight searched terms
set is							"Turn on in search mode
set showmode						"Show Current mode in the status bar
set showcmd						"Show partially-typed commands in the status line
set mouse=a						"Enable Mouse
set nocompatible 					"VIM over Vi
set undolevels=1500 					"how many times the user can undo
set sidescrolloff=3 					"space between cursor and terminal side
set tabstop=2 						"tab width
set shiftwidth=2
set noexpandtab						"Why would anyone ever expand tabs?
set smarttab
set nobackup 						"No default backup
"===========================
"Filetype Options
"===========================

filetype on						" enable filetype detection
autocmd FileType c,cpp,slang set cindent		" for C-like programming, have automatic indentation:


autocmd FileType c set formatoptions+=ro		" for actual C (not C++) programming where comments have explicit end
							" characters, if starting a new line in the middle of a comment automatically
							" insert the comment leader characters


autocmd FileType perl set smartindent			" for Perl programming, have things in braces indenting themselves


autocmd FileType html,css set noexpandtab tabstop=2	" for both CSS and HTML, use genuine tab characters for indentation, to make
							" files a few bytes smaller:

autocmd FileType make set noexpandtab shiftwidth=8	" in makefiles, don't expand tabs to spaces, since actual tab characters are
							" needed, and have indentation at 8 chars to be sure that all indents are tabs
							" (despite the mappings later)

"=============================
"Search Options
"=============================
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault
"=============================
"Generate ctags and show taglist
"=============================
set tags=tags;
