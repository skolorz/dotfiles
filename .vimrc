set nocompatible
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle "frigoeu/psc-ide-vim"
NeoBundle "raichoo/purescript-vim"
NeoBundle "valloric/youcompleteme"
NeoBundle "kien/ctrlp.vim"
NeoBundle "bling/vim-airline"
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'joequery/Stupid-EasyMotion'
"NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'tpope/vim-surround'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'agude/vim-eldar'

call neobundle#end()

filetype plugin indent on
syntax on
filetype on
set autoread
set wildmenu
set ignorecase
set smartcase
set hlsearch
set number
set relativenumber
set path-=/usr/include
set path+=$PWD/**
" backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set incsearch 
" Don't redraw while executing macros (good performance config)
set lazyredraw 
set showmatch 

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
try
    colorscheme basic-dark
catch: command not found
endtry
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Mapping
let mapleader = ","
let g:mapleader = ","
nmap <leader>n :set relativenumber!<cr>
" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>ve :e $MYVIMRC<cr>
nmap <leader>m :set paste!<cr>
nmap <leader>vr :so %<cr>
map <leader>r :!node %<cr>
"nnoremap ; :
:imap jj <Esc>
nmap <leader>h :%s//g
"Navigation
set so=7
nmap [ :bprevious<CR>
nmap ] :bnext<CR>
nmap <leader>bd :bd<cr>
" Purescript
let g:psc_ide_syntastic_mode = 2

" controlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'output$\|bower_components$\|node_modules$'
nmap <leader>pp :CtrlP<cr>
nmap <leader>pb :CtrlPBuffer<cr>
nmap <leader>pm :CtrlPMRUFiles<cr>
" ult snippets
let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"

" Ag search
let g:ackprg = 'ag --nogroup --nocolor --column'
nmap <leader>a :Ack  
nmap <leader>f :AckWindow 

" vim airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Save on window lost focus
"au FocusLost * silent! :wa

" Visual Mode
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" => Turn persistent undo on 
try
    set undodir=~/.vim/undodir
    set undofile
catch
endtry
" GIT
noremap <Leader>ga :!git add % && git status<CR>
noremap <Leader>gw :Gwrite<CR>
noremap <Leader>gp :!git add --patch<CR>
noremap <Leader>gs :!git status<CR>
noremap <Leader>gc :Git commit<CR>

NeoBundleCheck

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
