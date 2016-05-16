" Vundle
if !isdirectory(expand("~/.vim/bundle/vundle"))
    !mkdir -p ~/.vim/bundle
    !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    let s:bootstrap=1
endif
set nocompatible " be iMproved
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-eunuch'
Plugin 'kien/ctrlp.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/syntastic'
Plugin 'elixir-lang/vim-elixir'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'plasticboy/vim-markdown'
Plugin 'Blackrush/vim-gocode'
Plugin 'groenewege/vim-less'
Plugin 'moll/vim-node'
Plugin 'jplaut/vim-arduino-ino.git'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'Keithbsmiley/investigate.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'wting/rust.vim'
Plugin 'racer-rust/vim-racer'


" Snipmate..
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'jnurmine/Zenburn'

call vundle#end()

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
let g:ctrlp_user_command = 'cd %s && qf . | grep -Ev "\.pyc$|\.o$|\.so$|.*node_modules|.*bower_components"'
let g:ctrlp_working_path_mode = 0

let g:vim_markdown_folding_disabled=1
let g:syntastic_python_checkers = ['flake8']

map <Leader>c :nohlsearch<CR>
map <Leader>b :CtrlPBuffer<CR>
map <Leader>r :CtrlPMRUFiles<CR>
map <Leader>fs :cscope find s <C-R>=expand("<cword>")<CR><CR>
map <leader>fc :cscope find c <C-R>=expand("<cword>")<CR><CR>
map <leader>fg :cscope find g <C-R>=expand("<cword>")<CR><CR>
map <Leader>ff :cscope find f <C-R>=expand("<cfile>")<CR><CR>
map <Leader>fd :cscope find d <C-R>=expand("<cword>")<CR><CR>
map <Leader>fi :cscope find i <C-R>=expand("%")<CR><CR>

