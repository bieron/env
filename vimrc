"general
set nocompatible	"vim defaults
set history=200
set undolevels=400
set backup
set lazyredraw		"dont update while executing macros, etc
set complete=.,w,k,t ".currentWin, otherWins, dicKtionary, Tags
set autochdir       "cd to filedir

"search
set showmatch		"highlight corresponding bracket
set ignorecase
set smartcase		"do not ignore case when pattern has Mixed cAsE
set gdefault      "all search /g by default
set incsearch

"ui
set title
set nu				"line number
set ruler			"x,y of the cursor in the status line
set showcmd			"show partial command in status line
set viewoptions=folds,options,cursor,unix,slash
set wildmenu        "command-line completion operates in an enhanced mode
set wildignore=*.bak,*.o,*.e,*~
set showmode

"ui statusline
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
set statusline+=0x%B/%-8b\                      " current char
set statusline+=%v,
set statusline+=%(%l/%L%)

"copy
set paste
set pastetoggle=<Ins>

"colors
syntax on
colo roman
set mouse=a

"code
filetype on
set cindent
set foldenable
set foldmethod=syntax
set foldlevelstart=1
set shiftwidth=3
set shiftround
set tabstop=3
"set softtabstop=3
"set expandtab		"\t -> ' ' "won't affect existing, use :retab for that
set nowrap
set autoindent
set smartindent
set virtualedit=all

"commands
cmap W w
cmap Q q
cmap Wq wq
cmap WQ wq

source ~/.vim/vim-functions

map <F2> :call LocalDoc()<CR>
map <F3> :call Wiki()<CR>
map <F4> :call OnlineDoc()<CR>
map <F5> :call SwitchHls()<CR>

autocmd BufNewFile * call NewFile()
