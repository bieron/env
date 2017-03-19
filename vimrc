let mapleader="\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>s :mksession<CR>
"nnoremap <Leader>a :Ack<Space>

set guioptions=cagt


set nocompatible	" Use Vim defaults (much better!)
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=200
set undolevels=400
set backup
set backupdir=~/.vim/backup,/var/tmp
set directory=~/.vim/swap,/var/tmp

set complete=.,w,k,t " .currentWin, otherWins, dicKtionary, Tlist
set autoindent smartindent
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
set hlsearch incsearch
set showmode
set cursorline   "highlight line with cursor

"With these mappings, if 'smartcase' is on and you press * while on the word "The",
" you will only find "The" (case sensitive),
" but if you press * while on the word "the", the search will not be case sensitive.
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

nnoremap j gj "move to next physical line, do not get fooled by wraps
nnoremap k gk
nnoremap + <C-a>
"nnoremap - <C-d> " does not work
nnoremap <C-a> ^
nnoremap <C-e> $

" search using visually selected text
vnoremap // y/<C-R>"<CR>

" copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"nnoremap <BS> gg "backspace to beginning
"nnoremap <CR> G  "ENTER to eof (or line number)

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
"set foldlevelstart=1
set shiftwidth=4
set shiftround
set expandtab smarttab tabstop=4
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
"cmap W w
"cmap Q q
"cmap Wq wq
"cmap WQ wq

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
noremap <F4> :Gblame
"map <F5> :call SwitchHls()<CR>
noremap <F5> :!perl -cIlib %<CR>
noremap <F6> :!perlcritic -3 %<CR>
noremap <F7> :!perl -Ilib %<CR>

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
Plug 'airblade/vim-gitgutter'
"Plug 'altercation/vim-colors-solarized'
Plug 'bogado/file-line'
"Plug 'chrisbra/csv.vim'
"Plug 'henrik/vim-indexed-search'
"Plug 'luochen1990/rainbow'
"Plug 'Valloric/YouCompleteMe', {'do' : './install.sh --clang-completer'}
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
"Plug 'msanders/snipmate.vim'
Plug 'pjcj/vim-hl-var'
"Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/SelectBuf'
Plug 'vim-scripts/genutils'
Plug 'wincent/command-t', {'do' : 'rake make'}
Plug 'tpope/vim-commentary'
Plug 'vim-perl/vim-perl'
Plug 'ap/vim-css-color'
"Plug 'mileszs/ack.vim'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'derekwyatt/vim-fswitch' ".cpp <-> .h
call plug#end()
let g:CommandTWildIgnore=&wildignore . ",*/node_modules/*,*/tmp/*"

"let g:rainbow_active=0
"nnoremap <silent> <leader>r :RainbowToggle<CR>

" SYNTASTIC
"augroup mySyntastic
"  au!
"  au FileType tex let b:syntastic_mode = "passive"
"augroup END

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_check_on_open=0
"let g:syntastic_check_on_wq=0
"let g:syntastic_aggregate_errors=1
"let g:syntastic_enable_perl_checker=1
"let g:syntastic_perl_checkers='perl'
"nmap <silent> <leader>c :SyntasticCheck<CR>
"nmap <silent> <leader>c :!perl -c -Ilib %<CR>

"let g:cssColorVimDoNotMessMyUpdatetime = 1

" GIT GUTTER
nmap <silent> <leader>g :GitGutterToggle<CR>
nmap <silent> <leader>s :GitGutterSignsToggle<CR>
nmap <silent> <leader>h :GitGutterLineHighlightsToggle<CR>

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

let s:host_vimrc = $HOME .'/.'. hostname() .'.vimrc'
if filereadable(s:host_vimrc)
    execute 'source '. s:host_vimrc
endif

highlight TabLine ctermbg=gray

" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)
