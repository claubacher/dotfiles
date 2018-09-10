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
syntax on   " enable syntax processing
set encoding=utf-8

set ignorecase
set smartcase

let mapleader = " "

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

set t_Co=256
if $ITERM_PROFILE == 'Outside'
  set background=light
  colorscheme solarized
  let g:airline_theme='solarized'
else
  set background=dark
  colorscheme zenburn
endif

set wildignore+=*/tmp/*,*.so,*.swp,*~,._*,*.zip
set wildignore+=*/bower_components/*
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules|bower_components)$',
"   \ }

" set runtimepath^=~/.vim/bundle/ctrlp.vim

set rtp+=/usr/local/opt/fzf
nnoremap <Leader>p :FZF<Enter>

" if executable('ag')
"   let g:ackprg = 'ag --vimgrep'
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif
" cnoreabbrev Ack Ack!
" nnoremap <Leader>a :Ack!<Space>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,jsx,rt,json,md,css,scss,html,rb,hbs,handlebars}"
  \ -g "!{.git,node_modules,vendor,build,public}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nnoremap <Leader>f :F<Space>

" Softtabs, 2 spaces
set tabstop=2    " number of visual spaces
set softtabstop=2    " number of spaces when editing
set shiftwidth=2
set expandtab    " tabs are actually spaces

autocmd FileType elm setlocal expandtab tabstop=4 shiftwidth=4
au BufRead,BufNewFile *.rt set filetype=html

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Show line numbers
set number

set wildmenu    " visual autocomplete for command menu

" Open NERDTree on startup if no file specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" Close vim if only window left is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

hi TabLineFill ctermfg=Black

" move vertically by visual line
nnoremap j gj
nnoremap k gk

inoremap jk <ESC>

hi MatchParen cterm=none ctermbg=black ctermfg=blue
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
au InsertEnter * set cul
au InsertLeave * set nocul

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <Leader>s :SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['handlebars', 'javascript'] }
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'

let g:jsx_ext_required = 0
