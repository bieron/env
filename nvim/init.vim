lua << EOF
vim.g.mapleader = " "
local o = vim.opt

o.guioptions="cagt"
o.compatible=false  -- Use Vim defaults (much better!)
o.backspace="indent,eol,start" -- allow backspacing over everything in insert mode
o.history=200
o.undolevels=400
o.backup=true
o.backupdir="/var/tmp"

o.complete=".,w,k,t" -- .currentWin, otherWins, dicKtionary, Tlist
o.autoindent=true
o.smartindent=true
o.cindent=true

o.pastetoggle="<Insert>"
o.mouse=a

o.wildmenu=true -- use completion menu
o.wildmode="longest:list"
o.wildignore="*.bak,*.o,*.e,*~"
o.wildignorecase=true

o.smartcase=true   -- do not ignore case if pattern has mixed case (see ignorecase)
o.autowrite=true   -- automatically save before commands like :next and :make
o.lazyredraw=false -- update screen while executing macros etc.
o.title=true       -- shows the current filename and path in the term title.
o.showmatch=true   -- highlight corresponding bracket
o.ignorecase=true
o.gdefault=true    -- all search /g by default
o.hlsearch=true
o.incsearch=true
o.showmode=true
o.cursorline=true  -- highlight line with cursor

o.undofile=true -- Maintain undo history between sessions

o.nu=true
o.ruler=true
o.list=true

o.laststatus=2 -- always show status

o.foldenable=true
-- o.foldmethod=marker
-- o.foldmethod=syntax
-- o.foldlevelstart=1
o.shiftwidth=2
o.shiftround=true
o.expandtab=true
o.smarttab=true
o.tabstop=2
o.wrap=false
o.virtualedit="all"

o.splitbelow=true
o.splitright=true

-- o.foldmethod=indent,marker
o.foldnestmax=10
-- o.nofoldenable
o.foldlevel=2
o.inccommand="nosplit"
o.cc="100"

o.statusline= "%-3.3n " ..    -- buffer number
  "%f " ..
  "%h%m%r%w" ..
  "[%{strlen(&ft)?&ft:'none'}, " .. -- filetype
  "%{&encoding}, " ..
  "%{&fileformat}] " ..
  "%=" ..                           -- right align
  "   " ..
  "0x%B/%-8b " ..                   -- current char
  "%v," ..
  "%(%l/%L%)"


local map = vim.api.nvim_set_keymap

function nnoremap(from, to) map("n", from, to, {noremap=true}) end

nnoremap("<leader>w", ":w<cr>")
nnoremap("<leader>s", ":mksession<cr>")
-- With these mappings, if 'smartcase' is on and you press * while on the word "The",
--  you will only find "The" (case sensitive),
--  but if you press * while on the word "the", the search will not be case sensitive.
--nnoremap("*", "/<<C-R>=expand('<cword>')<CR>><CR>")
--nnoremap("#", "?<<C-R>=expand('<cword>')<CR>><CR>")
nnoremap("<F12>", ":set nu!<CR>")
nnoremap("<C-j>", ":r! ticket -k 2>/dev/null<CR>")

nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("<C-a>", "^")
nnoremap("+","<C-a>h") -- increment/decrement done sensibly
nnoremap("-","<C-x>")

-- search using visually selected text
map("n", "//", "y/<C-R>\"<CR>",{})

-- copy/paste to system clipboard
map("v", "<Leader>y", "\"+y", {})
map("v", "<Leader>d", "\"+d", {})
map("v", "<Leader>p", "\"+p", {})
map("v", "<Leader>P", "\"+P", {})
map("n", "<Leader>p", "\"+p", {})
map("n", "<Leader>P", "\"+P", {})

map("", "<F4>", ":Git blame", {noremap=true})
map("", "Y", "y$", {noremap=true})

map("n", "<leader>a", ":Ag<space>", {silent=true})
map("", "<C-s>", ":%s/\\s\\+$//e<CR>", {silent=true}) -- trim whitespaces

-- <Ctrl-l> redraws the screen and removes any search highlighting.
map("n", "<C-l>", ":nohl<CR><C-l>", {silent=true, noremap=true})

local cmd = vim.api.nvim_command

--move to next physical line, do not get fooled by wraps
--nnoremap <C-e> $

--filetype plugin indent on
--syntax on
-- autocmd BufNewFile * call functions#NewFile()

--nnoremap <C-Left> <C-W><LEFT>
--nnoremap <C-Right> <C-W><RIGHT>
--nnoremap <C-Down> <C-W><DOWN>
--nnoremap <C-Up> <C-W><UP>


-------------------------------------------------------------
--abbreviations
-------------------------------------------------------------
--noremap! [ []<LEFT>
--noremap! { {}<LEFT>
--noremap! ( ()<LEFT>
--noremap! " ""<LEFT>
--noremap! ' ''<LEFT>
map("i", "[", "[]<LEFT>",{noremap=true})
map("i", "{", "{}<LEFT>",{noremap=true})
map("i", "(", "()<LEFT>",{noremap=true})
map("i", '"', '""<LEFT>',{noremap=true})
map("i", "'", "''<LEFT>",{noremap=true})

-- noremap <F6> :!perlcritic -3 %<CR>
-- noremap <F7> :!perl -Ilib %<CR>
-- noremap <F8> :tabe term://pylint --rcfile var/pylintrc %<CR>
-- noremap <F8> :sp term://pylint --rcfile ~/.pylintrc %<CR>
-- --rcfile ~/.pylintrc %<CR>
-- noremap <F9> :sp term:///home/jb/.pyenv/shims/pylint %<CR>
-- noremap <F9> :!python -m py_compile %<CR>
-- autocmd FileType js noremap <F11> :!node -c %<CR>
-- "e    to open file and close the quickfix window
-- "o    to open (same as enter)
-- "go   to preview file (open but maintain focus on ag.vim results)
-- "t    to open in new tab
-- "T    to open in new tab silently
-- "h    to open in horizontal split
-- "H    to open in horizontal split silently
-- "v    to open in vertical split
-- "gv   to open in vertical split silently
-- "q    to close the quickfix window


-- let perl_fold=1
--let sh_fold_enabled=1
-- let perl_extended_vars=1
-- let perl_sync_dist=250

--map <F3> "jyiw:<C-r>j
--map <F7> ^"jyf;:! echo '\x \\ '"<C-r>j" \| psql tutsi<CR>
--map <F8> ^"jyf;:! psql -c "<C-r>j" tutsi<CR>
--vmap <F7> "jy:! echo '\x \\ '"<C-r>j" \| psql tutsi<CR>
--vmap <F8> "jy:! psql -c "<C-r>j" tutsi<CR>

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

--Plug 'altercation/vim-colors-solarized'
--Plug 'chrisbra/csv.vim'
--Plug 'henrik/vim-indexed-search'
--Plug 'luochen1990/rainbow'
--Plug 'Valloric/YouCompleteMe', {'do' : './install.sh --clang-completer'}
--Plug 'msanders/snipmate.vim'
--Plug 'mileszs/ack.vim'
--Plug 'xolox/vim-misc'
--Plug 'xolox/vim-easytags'
--Plug 'scrooloose/nerdtree'
--Plug 'jistr/vim-nerdtree-tabs'
--Plug 'derekwyatt/vim-fswitch' ".cpp <-> .h
--Plug 'mileszs/ack.vim'

Plug 'airblade/vim-gitgutter'
-- Plug 'bogado/file-line' " https://github.com/bogado/file-line/issues/56
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
-- Plug 'pjcj/vim-hl-var'
-- Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/SelectBuf'
Plug 'vim-scripts/genutils'
Plug('wincent/command-t', { ["do"] = "rake make" })
Plug 'tpope/vim-commentary'
-- " Plug 'vim-perl/vim-perl'
Plug 'ap/vim-css-color'
Plug 'rking/ag.vim'
Plug 'leafgarland/typescript-vim'
-- Plug 'jacoborus/tender.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'rust-lang/rust.vim'

-- Plug 'nvie/vim-flake8'
-- Plug 'Quramy/tsuquyomi'
-- Plug 'HerringtonDarkholme/yats.vim'
-- Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
-- For async completion
-- Plug 'Shougo/deoplete.nvim'
-- For Denite features
-- Plug 'Shougo/denite.nvim'
-- Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug('neoclide/coc.nvim' , { branch = "release" })
vim.call("plug#end")

map("n", "<leader>g", ":GitGutterToggle<CR>", {silent=true})

vim.g.coc_global_extensions = { 'coc-tsserver' }
vim.g.gitgutter_max_signs=500  -- default value
vim.g.typescript_compiler_options = '--lib es6'


-- https://github.com/neoclide/coc.nvim/issues/531
map("n", "<Esc>", ":call coc#float#close_all()<CR>", {})
-- Remap keys for applying codeAction to the current line.
map("n", "<leader>cc", "<Plug>(coc-codeaction)", {})

-- Apply AutoFix to problem on the current line.
map("n", "<leader>cf","<Plug>(coc-fix-current)", {})
nnoremap("<leader><ESC>",":call coc#util#float_hide()<CR>", {})
-- Show autocomplete when Tab is pressed
map("i", "<Tab>", "coc#refresh", {silent=true, expr=true})
-- inoremap <silent><expr> <Tab> coc#refresh()


-- GoTo code navigation.
map("n", "gd", "<Plug>(coc-definition)", {silent=true})
map("n", "gy", "<Plug>(coc-type-definition)", {silent=true})
map("n", "gi", "<Plug>(coc-implementation)", {silent=true})
map("n", "gr", "<Plug>(coc-references)", {silent=true})
map("n", "<leader>e", "<Plug>(coc-diagnostic-next-error)", {silent=true})
map("n", "<leader>r", "<Plug>(coc-diagnostic-next)", {silent=true})

map("n","K", ":call Show_documentation()<CR>", {silent=true,noremap=true})


--  autocmd FileType typescript setlocal completeopt-=menu

--  SYNTASTIC
--  set statusline+=%#warningmsg#
--  set statusline+=%{SyntasticStatuslineFlag()}
--  set statusline+=%*
--  let g:syntastic_aggregate_errors=1
--  let g:syntastic_always_populate_loc_list = 0
--  let g:syntastic_auto_loc_list = 0
--  let g:syntastic_check_on_open = 0
--  let g:syntastic_check_on_wq = 0
--  let g:syntastic_enable_signs=0
--  let g:syntastic_mode="passive"
--  let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': []}
--  nnoremap <leader>c :SyntasticCheck<CR> :lopen<CR>
-- let g:flake8_show_in_file=1
-- let g:flake8_show_in_gutter=1

--  map <space> \

--  GIT GUTTER
--  nmap <silent> <leader>s :GitGutterSignsToggle<CR>
--  nmap <silent> <leader>h :GitGutterLineHighlightsToggle<CR>

-- You can jump between hunks:
--    jump to next hunk (change): ]c
--    jump to previous hunk (change): [c.

-- You can stage or revert an individual hunk when your cursor is in it:
--    stage the hunk with <Leader>hs or
--    revert it with <Leader>hr.

-- " ----- xolox/vim-easytags settings -----
-- " Where to look for tags files
-- set tags=./tags;,~/.vimtags
-- " Sensible defaults
-- let g:easytags_events = ['BufReadPost', 'BufWritePost']
-- let g:easytags_async = 1
-- let g:easytags_dynamic_files = 2
-- let g:easytags_resolve_links = 1
-- let g:easytags_suppress_ctags_warning = 1
-- 
-- " ----- majutsushi/tagbar settings -----
-- " Open/close tagbar with \b
-- nmap <silent> <leader>b :TagbarToggle<CR>
-- " Uncomment to open tagbar automatically whenever possible
-- "autocmd BufEnter * nested :call tagbar#autoopen(0)


-- let g:syntastic_error_symbol = '✘'
-- let g:syntastic_warning_symbol = "▲"
-- nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
-- let g:NERDTreeShowHidden=1
-- let g:nerdtree_tabs_open_on_console_startup=1

-- nmap <silent> <leader>t :CommandT<CR> "default

-- let g:netrw_liststyle = 3
-- let g:netrw_winsize   = 15
-- let g:netrw_banner = 0
-- nmap <silent> <leader>t :Lex<CR>
-- autocmd VimEnter * Lexplore
--  colo Monokai
--  colo tender
--  let g:neodark#use_256color = 1
--  set bg=dark

--  Highlight a column in csv text.
--  :Csv 1    " highlight first column
--  :Csv 12   " highlight twelfth column
--  :Csv 0    " switch off highlight
-- function! CSVH(colnr)
--   if a:colnr > 1
--     let n = a:colnr - 1
--     execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
--     execute 'normal! 0'.n.'f,'
--   elseif a:colnr == 1
--     match Keyword /^[^,]*/
--     normal! 0
--   else
--     match
--   endif
-- endfunction
-- command! -nargs=1 Csv :call CSVH(<args>)

--  hi TabLine ctermfg=Grey ctermbg=Black
--  hi TabLineSel ctermfg=Yellow ctermbg=Black

-- highlight DiffAdd    cterm=none ctermfg=Black ctermbg=DarkGreen  gui=none guifg=bg guibg=DarkGreen
-- highlight DiffDelete cterm=none ctermfg=Black ctermbg=DarkRed    gui=none guifg=bg guibg=DarkRed
-- highlight DiffChange cterm=none ctermfg=Black ctermbg=DarkYellow gui=none guifg=bg guibg=Yellow
-- highlight DiffText   cterm=none ctermfg=Black ctermbg=LightBlue  gui=none guifg=bg guibg=Magenta


-- nnoremap <F3> :make -C build/clang<CR>
-- inoremap <F3> <ESC>:make -C build/clang<CR>
-- nnoremap <F4> :make dd<CR>
-- inoremap <F4> <ESC>:make dd<CR>
-- nnoremap <F5> :make release<CR>
-- inoremap <F5> <ESC>:make release<CR>
-- nnoremap <F6> :make test<CR>
-- inoremap <F6> <ESC>:make test<CR>
-- nnoremap <F2> :wa<CR>
-- inoremap <F2> <ESC>:wa<CR>a
-- 
-- nnoremap <F7> :botright cw<CR>:set colorcolumn=0<CR>
-- inoremap <F7> <ESC>:botright cw<CR>:set colorcolumn=0<CR>
-- nnoremap <F8> :ccl<CR>
-- inoremap <F8> <ESC>:ccl<CR>
-- 
-- nnoremap <F9> :cprev<CR>
-- inoremap <F9> <ESC>:cprev<CR>
-- nnoremap <F10> :cnext<CR>
-- inoremap <F10> <ESC>:cnext<CR>

--  function! Test() range
--      echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")))
--  endfunction

--  https://sanctum.geek.nz/arabesque/vim-anti-patterns/
--  noremap <Up> <nop>
--  noremap <Down> <nop>
--  noremap <Left> <nop>
--  noremap <Right> <nop>
-- 
--  set directory=~/.vim/swap,/var/tmp

EOF
autocmd BufNewFile * call functions#NewFile()

autocmd FileType cpp setlocal foldmethod=marker foldmarker={,}
autocmd FileType perl iab ddd use Data::Dump q/pp/;<ESC>F%s<C-o>:call getchar()<CR><ESC>i
autocmd FileType perl iab ddw warn pp;<LEFT>
autocmd FileType perl map <buffer> <F7> :!perlcritic -3 %<CR>
autocmd FileType perl noremap <F5> :!perl -cIlib %<CR>
autocmd FileType python iab ww from warnings import warn<CR>from pprint import pformat<CR>warn(pformat(<ESC>F%s<C-o>:call getchar()<CR><ESC>i
autocmd FileType python noremap <F10> :sp term://python3 -mpylint --rcfile ~/.pylintrc %<CR>
autocmd FileType python noremap <F11> :!python3 -m py_compile %<CR>
autocmd FileType python noremap <F8> :sp term://python3 -mpyflakes %<CR>
autocmd FileType python noremap <buffer> <F7> :call flake8#Flake8()<CR>
autocmd FileType python setlocal foldmethod=indent
autocmd FileType typescript iab asy async
autocmd FileType typescript iab aw await
autocmd FileType typescript iab ddd this.dLogger.warn(<ESC>F%s:call getchar()
autocmd FileType typescript inoreab ins console.log(inspect(  , false, 42, true));
autocmd FileType typescript inoreab insp import {inspect} from 'util';
autocmd FileType typescript noremap <F11> :!tsc -m commonjs -t ES2019 %<CR>
autocmd FileType typescriptreact setlocal filetype=typescript


hi Normal ctermbg=None
hi NonText ctermfg=DarkGrey
hi CocInfoSign ctermbg=8
colorscheme neodark


let g:deoplete#enable_at_startup = 1

function! Show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:CommandTWildIgnore=&wildignore . ",*/node_modules/*,*/tmp/*"
