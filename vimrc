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
Plugin 'cespare/vim-toml'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'


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
    au BufWritePost *.c,*.cpp,*.c++,*.h,*.hpp :call UpdateGtagSymbols()

    au FileType rust nmap <leader>gg :call racer#GoToDefinition()<CR>
    au FileType rust nmap <leader>gd :call racer#ShowDocumentation()<CR>

    au FileType c,cpp nmap <Leader>gs :cscope find s <C-R>=expand("<cword>")<CR><CR>
    au FileType c,cpp nmap <leader>gc :cscope find c <C-R>=expand("<cword>")<CR><CR>
    au FileType c,cpp nmap <leader>gg :cscope find g <C-R>=expand("<cword>")<CR><CR>
    au FileType c,cpp nmap <Leader>gf :cscope find f <C-R>=expand("<cfile>")<CR><CR>
    au FileType c,cpp nmap <Leader>gd :cscope find d <C-R>=expand("<cword>")<CR><CR>
    au FileType c,cpp nmap <Leader>gi :cscope find i <C-R>=expand("%")<CR><CR>
endif

if has("cscope")
    set cscopeprg=gtags-cscope " Use gtags, fast as hell
    set cscopetag     " tag commands will fallback to cscope if available
    set cscopeverbose " Adds some useful status messages?
    if filereadable("GTAGS")
        cscope add ./GTAGS
    endif
endif

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

let g:vim_markdown_folding_disabled=1

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 1
let g:syntastic_loc_list_height = 3

let g:racer_cmd = 'racer'

map <Leader>c :nohlsearch<CR>
map <Leader>b :Buffers<CR>
map <Leader>f :Files<CR>


" Function definitions


function UpdateGtagSymbols()
    if filereadable("GTAGS")
        silent !global -u
    endif
endfunction
