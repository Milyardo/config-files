set nocompatible        "VIM over Vi
"==========================
"Pathogen Init
"==========================
execute pathogen#infect()
"==========================
"Vim OmniComplete
"==========================
set ofu=syntaxcomplete#Complete
"==========================
"Vim UI Options
"==========================
syntax on               "Turn on Syntax Highlighting
set background=dark     "Self explanatory
colorscheme solarized
set number              "Turn on Line Numbering
set nowrap              "No line wrapping
set ruler               "Set cursor position in vim status line
set is                  "Turn on in search mode
set showmode            "Show Current mode in the status bar
set showcmd             "Show partially-typed commands in the status line
set mouse=a             "Disable Mouse
set undolevels=1500     "how many times the user can undo
set sidescrolloff=3     "space between cursor and terminal side
set tabstop=2           "tab width
set shiftwidth=2        "Shift Width
set expandtab           "Why would anyone ever expand tabs? :(
set smarttab            "SmartTab for Smart People
set nobackup            "No default backup; That's what git is for.
set incsearch           "Incrementtal Search
set cursorline          "Highlight the current line that the cursor is on.
set clipboard+=unnamedplus  "Use the system clipboard as well
set switchbuf=useopen    "Use already open buffers when swiching
set encoding=utf8        "UTF-8 all the time, every time
set cc=80
"Ignore a few files.
set wildignore+=*.o,*.class,*.obj,.git,.hg,**/target/**
nnoremap ZZ :wqall<CR>
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
autocmd Filetype jsp set textwidth=0 "More HTML like files

autocmd FileType java set textwidth=79 "I like text wrapping in Java.
"=============================
"Search Options
"=============================
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase
set hls             "Highlight searched terms

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault
autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"=============================
"Enable and disable mouse use
"=============================
noremap <f12> :call ToggleMouse() <CR>
function! ToggleMouse()
set number
else
set nonumber
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
"Command-T Options
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
noremap <leader>l :TagbarToggle<CR>
noremap <leader>[ :sbuffer __Tagbar__<CR>
"============================
"Indent Guide Color Options
"============================
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgrey
"Run stuff on open
autocmd VimEnter * :TagbarToggle
autocmd VimEnter * :IndentGuidesEnable
autocmd VimEnter * :SrcExplToggle
"============================
"TagFile Options
"============================
set tags=tags;,~/.vimtags
let g:easytags_dynamic_files = 1
let g:easytags_auto_update = 0
"============================
"Src Explorer Options
"============================
"The switch of the Source Explorer 
noremap <leader>k :SrcExplToggle<CR> 
"Focus SrcExpl when pressed
noremap <leader>] :sbuffer Source_Explorer<CR>
"Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 

"Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

"Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 

"Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

"In order to Avoid conflicts, the Source Explorer should know what plugins 
"are using buffers. And you need add their bufname into the list below 
"according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tagbar__", 
        \ "_NERD_tree_1", 
        \ "Source_Explorer",
        \  "GoToFile" 
    \ ]

"Enable/Disable the local definition searching, and note that this is not 
"guaranteed to work, the Source Explorer doesn't check the syntax for now. 
"It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 0 

"Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

"Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
"create/update a tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase --totals=yes --exclude=deploy/* --exclude=*/target/* -R ."

"Set "<leader>'" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<leader>'"
"============================
"Blame mappers
"============================
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
"============================
"NERDTree Options
"============================
let NERDTreeHightlightCursorline=1
nmap <leader>n :NERDTreeToggle<cr>
