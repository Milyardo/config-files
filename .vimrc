"==========================
"Pathogen Init
"==========================
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"==========================
"Vim OmniComplete
"==========================
set ofu=syntaxcomplete#Complete
"==========================
"Vim UI Options
"==========================
colorscheme default
syntax on               "Turn on Syntax Highlighting
set number              "Turn on Line Numbering
set nowrap              "No line wrapping
set ruler               "Set cursor position in vim status line
set is                  "Turn on in search mode
set showmode            "Show Current mode in the status bar
set showcmd             "Show partially-typed commands in the status line
set mouse-=a            "Disable Mouse
set nocompatible        "VIM over Vi
set undolevels=1500     "how many times the user can undo
set sidescrolloff=3     "space between cursor and terminal side
set tabstop=2           "tab width
set shiftwidth=2        "Shift Width
set expandtab           "Why would anyone ever expand tabs? :(
set smarttab            "SmartTab for Smart People
set nobackup            "No default backup; That's what git is for.
set tw=79               "Text wrapping is nice
set incsearch           "Incrementtal Search
set cursorline          "Highlight the current line that the cursor is on.
set clipboard+=unnamedplus  "Use the system clipboard as well
"===========================
"Filetype Options
"===========================
filetype on           " enable filetype detection
autocmd FileType c,cpp,slang set cindent    " for C-like programming, have automatic indentation:


autocmd FileType c set formatoptions+=ro    "for actual C (not C++) programming
                                            "where comments have explicit end
                                            " characters, if starting a new 
                                            "line in the middle of a comment automatically
                                            " insert the comment leader characters

autocmd FileType perl set smartindent     " for Perl programming, have things
                                          "in braces indenting themselves

autocmd FileType make set noexpandtab shiftwidth=8  " in makefiles, don't
                                                    " expand tabs to spaces,
                                                    " since actual tab
                                                    " characters are needed,
                                                    " and have indentation at 8
                                                    " chars to be sure that all
                                                    " indents are tabs
                                                    " (despite the mappings
                                                    " later)
autocmd FileType html set textwidth=0 " set no textwrapping on HTML files.
autocmd FileType xhtml set textwidth=0 " same thing for xhtml
"=============================
"Search Options
"=============================
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase
set hls             "Highlight searched terms

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault
"=============================
"Generate ctags and show taglist
"=============================
set tags=tags;

"=============================
"Enable and disable mouse use
"=============================
noremap <f12> :call ToggleMouse() <CR>
function! ToggleMouse()
if &mouse == 'a'
set mouse=
set number
echo "Mouse usage disabled"
else
set mouse=a
set nonumber
echo "Mouse usage enabled"
endif
endfunction
"=============================
" OmniComplete
"=============================
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"=============================
"Command-T Bindings
"=============================
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>
"=============================
" Close Tag support
"=============================
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
"============================
" TagBar Binding
"============================
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>
"============================
"Indent Guide Color Options
"============================
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgrey
"Run stuff on open
autocmd VimEnter * :TagbarToggle
autocmd VimEnter * :IndentGuidesEnable
"============================
"TagFile Options
"============================
set tags=tags;,~/.vimtags
let g:easytags_dynamic_files = 1
let g:easytags_auto_update = 0
"============================
"PretyXML Function
"============================
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
