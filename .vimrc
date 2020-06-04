execute pathogen#infect()

set nocompatible " be iMproved
filetype off " required!

set autochdir
syn sync maxlines=5000
syntax sync fromstart

" custom
map <F5> :make<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>
set incsearch " incremental search, as the text is typed
set mouse=a
au BufNewFile,BufRead,BufReadPost *.mod setf lprolog " lambda prolog

" LatexBox
let g:LatexBox_latexmk_options = "-pvc -pdfps"
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv

" autocomplete dictionaties
au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
set complete+=k

let mapleader = ","

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#rc()

"Bundle 'LaTeX-Box-Team/LaTeX-Box'
"Bundle 'scrooloose/nerdtree'
"Bundle 'tpope/vim-surround'
"Bundle 'msanders/snipmate.vim'
"Bundle 'godlygeek/tabular'
"Bundle 'tpope/vim-unimpaired'
"Bundle 'vim-scripts/searchfold.vim'
"Bundle 'tpope/vim-endwise'
"Bundle 'kchmck/vim-coffee-script'
"Bundle 'mattn/gist-vim'
"Bundle 'kien/ctrlp.vim'
"Bundle 'juvenn/mustache.vim'
"Bundle 'tpope/vim-commentary'
"Bundle 'vim-ruby/vim-ruby'
"Bundle 'vim-scripts/taglist.vim'
"Bundle 'mattn/webapi-vim'
"Bundle 'derekwyatt/vim-scala'
"Bundle 'kalmanb/sbt-ctags'
"Bundle 'lyosha/ctags-go.git'
"Bundle 'majutsushi/tagbar'
"Bundle 'avsm/ocaml-annot'
"Bundle 'kongo2002/fsharp-vim'
"Bundle 'mileszs/ack.vim'
Plugin 'posva/vim-vue'

call vundle#end()            " required
filetype plugin indent on    " required

set number
syntax on
set autoread " Automatically reload changes if detected
set ruler
set encoding=utf8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif


" CTags
map <Leader>rt :!/usr/bin/ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Guardfile} set ft=ruby
"
" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupWrapping()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript
au BufRead,BufNewFile *.txt call s:setupWrapping()

" Mustache configuration
au BufNewFile,BufRead *.mustache setf mustache

" Yaml Configuration
au BufRead,BufNewFile *.{yml,yaml} set foldmethod=indent

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Use modeline overrides
set modeline
set modelines=10

set cursorline

" Default color scheme
color desert

" Show (partial) command in the status line
set showcmd
" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Patter ignore when use the completion in search file
set wig=*.o,*.obj,*~,#*#,*.pyc,*.tar*,*.avi,*.ogg,*.mp3

" Delete all whitespace in end of line
autocmd BufWritePre * :%s/\s\+$//e

" Autocomplete Fabricator gem
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()

" Autocomplete Fabricator gem
autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()

set foldmethod=syntax

let g:Powerline_symbols = 'fancy'
set t_Co=256

let Tlist_Auto_Update = 'true'
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

"spell check when writing commit logs
autocmd filetype svn,*commit* set spell

let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$\',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Read-only .doc through antiword
autocmd BufReadPre *.doc silent set ro
autocmd BufReadPost *.doc silent %!antiword "%"

" Read-only odt/odp through odt2txt
autocmd BufReadPre *.odt,*.odp silent set ro
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"

" Read-only rtf through unrtf
autocmd BufReadPre *.rtf silent set ro
autocmd BufReadPost *.rtf silent %!unrtf --text

"elpi
autocmd BufRead,BufNewFile *.elpi set filetype=lprolog

autocmd FileType lprolog syn region  lprologClause start="^\w\+" end=" \|:-\|\."
autocmd FileType lprolog syn match lprologClauseSymbols ":-"
autocmd FileType lprolog syn match lprologClauseSymbols "\."
autocmd FileType lprolog hi def link lprologClauseSymbols Type

autocmd FileType lprolog syn keyword elpiKeyword mode macro type pred
autocmd FileType lprolog syn match elpiKeyword ":before"
autocmd FileType lprolog syn match elpiKeyword ":after"
autocmd FileType lprolog syn match elpiKeyword ":name"
autocmd FileType lprolog syn match elpiMacro "@\(\w\|-\)\+"
autocmd FileType lprolog syn match elpiSpill "{"
autocmd FileType lprolog syn match elpiSpill "}"
autocmd FileType lprolog syn region elpiQuotation start="{{" end="}}" contains=@elpiAntiQuotation
autocmd FileType lprolog hi def link elpiKeyword Keyword
autocmd FileType lprolog hi def link elpiMacro Special
autocmd FileType lprolog hi def link elpiSpill Special

autocmd BufRead scp://* :set bt=acwrite
