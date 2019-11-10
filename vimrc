if has("nvim") && empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'

Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
endif

if filereadable('/usr/share/vim/vimfiles/plugin/fzf.vim')
  Plug '/usr/share/vim/vimfiles/plugin/fzf.vim'
  Plug 'junegunn/fzf.vim'
else
  echo 'fzf Plug configuration missing!'
endif

call plug#end()


let g:deoplete#enable_at_startup = 1
let g:airline#extensions#ale#enabled = 1
let g:gruvbox_italic = 1
let g:LanguageClient_diagnosticsSignsMax = v:null

colorscheme gruvbox
set background=dark

set signcolumn=yes
set hidden
set relativenumber
set ignorecase
set smartcase
set incsearch
set termguicolors

if has("nvim")
  call deoplete#custom#option('sources', {
  \   '_': ['LanguageClient'],
  \})
  let g:LanguageClient_serverCommands = {
  \   'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
  \   'javascript': ['npx', 'javascript-typescript-stdio'],
  \   'javascript.tsx': ['npx', 'javascript-typescript-stdio'],
  \   'typescript': ['npx', 'javascript-typescript-stdio'],
  \   'typescript.tsx': ['npx', 'javascript-typescript-stdio'],
  \}
  let g:ale_fixers = {
  \   '*': ['trim_whitespace'],
  \   'javascript': ['prettier', 'eslint'],
  \   'javascript.tsx': ['prettier', 'eslint'],
  \   'typescript': ['prettier', 'eslint'],
  \   'typescript.tsx': ['prettier', 'eslint'],
  \}

  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
endif

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-b> :Buffers<CR>
nmap <silent> <C-p> :GFiles<CR>
nmap <silent> <leader>p :Files<CR>
