" Vundle
if !isdirectory(expand("~/.vim/bundle/vundle"))
    !mkdir -p ~/.vim/bundle
    !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    let s:bootstrap=1
endif
set nocompatible " be iMproved
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-eunuch'
Bundle 'kien/ctrlp.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'mattn/emmet-vim'
Bundle 'othree/html5.vim'
Bundle 'scrooloose/syntastic'
Bundle 'elixir-lang/vim-elixir'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'plasticboy/vim-markdown'
Bundle 'Blackrush/vim-gocode'
Bundle 'groenewege/vim-less'
Bundle 'moll/vim-node'
Bundle 'jplaut/vim-arduino-ino.git'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'Keithbsmiley/investigate.vim'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'wting/rust.vim'

" Snipmate..
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'jnurmine/Zenburn'

if exists("s:bootstrap") && s:bootstrap
    unlet s:bootstrap
    BundleInstall
endif

filetype plugin indent on
syntax on

" Personal settings
set ignorecase
set smartcase
set hlsearch
set incsearch
colorscheme zenburn

" Do not split window when opening file/switching buffer from dirty buffer
set hidden

if has("gui_running")
    set gfn=DejaVu\ Sans\ Mono\ 8
    set go=aegimLt
    set background=dark
    set guicursor+=a:blinkon0
endif

if has("autocmd")
    " Make vim save and load the folding of the document each time it loads,
    " also places the cursor in the last place that it was left.
    au BufWinLeave *.* mkview
    au BufWinEnter *.* silent loadview
    au FileType less setlocal expandtab shiftwidth=2 softtabstop=2
    au FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
    au FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
    au FileType gitcommit set spell
endif

if has("cscope")
    set cscopeprg=gtags-cscope " Use gtags, fast as hell
    set cscopetag     " tag commands will fallback to cscope if available
    set cscopeverbose " Adds some useful status messages?
    if filereadable("GTAGS")
        cscope add ./GTAGS
    endif
endif

" Use 'quickfind' as ctrlp file searcher
" https://github.com/akojo/quickfind.git
let g:ctrlp_user_command = 'cd %s && qf . | grep -Ev "\.o$|^(\.\/)?node_modules"'
let g:ctrlp_working_path_mode = 0

let g:vim_markdown_folding_disabled=1

map <Leader>c :nohlsearch<CR>
map <Leader>b :CtrlPBuffer<CR>
map <Leader>r :CtrlPMRUFiles<CR>
map <Leader>fs :cscope find s <C-R>=expand("<cword>")<CR><CR>
map <leader>fc :cscope find c <C-R>=expand("<cword>")<CR><CR>
map <leader>fg :cscope find g <C-R>=expand("<cword>")<CR><CR>
map <Leader>ff :cscope find f <C-R>=expand("<cword>")<CR><CR>
map <Leader>fd :cscope find d <C-R>=expand("<cword>")<CR><CR>
map <Leader>fi :cscope find i <C-R>=expand("<cword>")<CR><CR>

