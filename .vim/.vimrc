" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch    " highlight matches
syntax enable   " enable syntax processing
set encoding=utf-8

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

execute pathogen#infect()

" Softtabs, 2 spaces
set tabstop=2    " number of visual spaces
set softtabstop=2    " number of spaces when editing
set shiftwidth=2
set expandtab    " tabs are actually spaces

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Show line numbers
set number

set wildmenu    " visual autocomplete for command menu

let mapleader = " "

nnoremap <Leader>o :tabnew<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprevious<CR>

" Open NERDTree on startup if no file specified
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
" Close vim if only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

hi TabLineFill ctermfg=Black

let g:user_emmet_leader_key = '<c-z>'

colorscheme badwolf

" move vertically by visual line
nnoremap j gj
nnoremap k gk

inoremap jk <ESC>
