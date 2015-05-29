"set guioptions+=c
"set guioptions=agimrLtT
set guioptions=cagt
"set guioptions-=b
"set guioptions-=R
"set guioptions-=e
"set guioptions-=m  "remove menu bar
"set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar
"set guioptions-=L  "remove left-hand scroll bar

set nocompatible	" Use Vim defaults (much better!)
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=200
set undolevels=400
set backup
set backupdir=~/.vim/backup,/var/tmp
set directory=~/.vim/swap,/var/tmp

set complete=.,w,k,t " .currentWin, otherWins, dicKtionary, Tlist
set autoindent		" default autoindenting
set smartindent
"set cindent

set pastetoggle=<Insert>
set mouse=a

set wildmenu		" use completion menu
set wildmode=longest:list
set wildignore=*.bak,*.o,*.e,*~
set wildignorecase

set smartcase 		" do not ignore case if pattern has mixed case (see ignorecase)
set autowrite 		" automatically save before commands like :next and :make
set lazyredraw		" do not update screen while executing macros etc.
set title 		" shows the current filename and path in the term title.
set showmatch     "highlight corresponding bracket
set ignorecase
set smartcase     "do not ignore case when pattern has Mixed cAsE
set gdefault      "all search /g by default
set hlsearch
set incsearch
set showmode

set nu
set ruler

set laststatus=2    "always show status
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
"set statusline+=%#perlInfo#%{CurrentFunction()}%*
set statusline+=\ \ \
"set statusline+=0x%B/%-8b\                      " current char
set statusline+=%v,
set statusline+=%(%l/%L%)
set shortmess+=I

filetype plugin indent on
set foldenable
set foldmethod=marker
"set foldmethod=syntax
set foldlevelstart=1
set shiftwidth=4
set shiftround
set expandtab
set tabstop=4
set nowrap
set virtualedit=all

"split resize on <C-w>
"set winwidth=118
"set winminwidth=24

syntax on
noremap Y y$
"autocmd BufWritePre * :%s/\s\+$//e "trim whitespaces
autocmd BufNewFile * call functions#NewFile()

"commands
cmap W w
cmap Q q
cmap Wq wq
cmap WQ wq

noremap <c-LEFT> <C-W><LEFT>
noremap <c-RIGHT> <C-W><RIGHT>
noremap <c-DOWN> <C-W><DOWN>
noremap <c-UP> <C-W><UP>

"-----------------------------------------------------------
"abbreviations
"-----------------------------------------------------------
map! [ []<LEFT>
map! { {}<LEFT>
map! ( ()<LEFT>

"map <F2> :call LocalDoc()<CR>
"map <F3> :call Wiki()<CR>
"map <F4> :call OnlineDoc()<CR>
map <F4> :Gblame
"map <F5> :call SwitchHls()<CR>

iab ddd use Data::Dump 'pp';<ESC>F%s<C-o>:call getchar()<CR><ESC>i
iab ddw warn pp;<LEFT>

"let perl_fold=1
"let sh_fold_enabled=1
"let perl_extended_vars=1
"let perl_sync_dist=250

"map <F3> "jyiw:<C-r>j
"map <F7> ^"jyf;:! echo '\x \\ '"<C-r>j" \| psql tutsi<CR>
"map <F8> ^"jyf;:! psql -c "<C-r>j" tutsi<CR>
"vmap <F7> "jy:! echo '\x \\ '"<C-r>j" \| psql tutsi<CR>
"vmap <F8> "jy:! psql -c "<C-r>j" tutsi<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'wincent/command-t', {'do' : 'rake make'}
Plug 'scrooloose/syntastic'
Plug 'msanders/snipmate.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/genutils'
Plug 'vim-scripts/SelectBuf'
Plug 'altercation/vim-colors-solarized'
Plug 'bogado/file-line'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'derekwyatt/vim-fswitch' ".cpp <-> .h
call plug#end()

" SYNTASTIC
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_perl_checker=1
let g:syntastic_perl_checkers='perl'
nmap <silent> <leader>c :SyntasticCheck<CR>
"nmap <silent> <leader>c :!perl -c -Ilib %<CR>

" GIT GUTTER
nmap <silent> <leader>g :GitGutterToggle<CR>
nmap <silent> <leader>s :GitGutterSignsToggle<CR>
nmap <silent> <leader>h :GitGutterLineHighlightsToggle<CR>

nnoremap <C-j> :r! issue<CR>

let g:gitgutter_max_signs=500  " default value
"You can jump between hunks:
"   jump to next hunk (change): ]c
"   jump to previous hunk (change): [c.

"You can stage or revert an individual hunk when your cursor is in it:
"   stage the hunk with <Leader>hs or
"   revert it with <Leader>hr.

"" ----- xolox/vim-easytags settings -----
"" Where to look for tags files
"set tags=./tags;,~/.vimtags
"" Sensible defaults
"let g:easytags_events = ['BufReadPost', 'BufWritePost']
"let g:easytags_async = 1
"let g:easytags_dynamic_files = 2
"let g:easytags_resolve_links = 1
"let g:easytags_suppress_ctags_warning = 1
"
"" ----- majutsushi/tagbar settings -----
"" Open/close tagbar with \b
"nmap <silent> <leader>b :TagbarToggle<CR>
"" Uncomment to open tagbar automatically whenever possible
""autocmd BufEnter * nested :call tagbar#autoopen(0)


"let g:syntastic_error_symbol = '✘'
"let g:syntastic_warning_symbol = "▲"
"nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
"let g:NERDTreeShowHidden=1
"let g:nerdtree_tabs_open_on_console_startup=1

"nmap <silent> <leader>t :CommandT<CR> "default

"let g:netrw_liststyle = 3
"let g:netrw_winsize   = 15
"let g:netrw_banner = 0
"nmap <silent> <leader>t :Lex<CR>
"autocmd VimEnter * Lexplore
colo herald
