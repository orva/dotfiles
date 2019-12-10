if has('nvim')
  let plugdir = stdpath('data') . '/plugged'
else
  let plugdir = '~/.local/share/vim/plugged'
endif

call plug#begin(plugdir)

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mustache/vim-mustache-handlebars'

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
elseif isdirectory(glob('$HOME/.fzf'))
  Plug '~/.fzf'
  Plug 'junegunn/fzf.vim'
else
  echo 'fzf Plug configuration missing!'
endif

call plug#end()

" for vim, to be sure
filetype plugin indent on

colorscheme gruvbox
set background=dark
set signcolumn=yes
set hidden
set relativenumber
set ignorecase
set smartcase
set incsearch
set termguicolors

let g:airline#extensions#ale#enabled = 1
let g:gruvbox_italic = 1
let g:ale_fixers = {
 \   '*': ['trim_whitespace'],
 \   'javascript': ['prettier', 'eslint'],
 \   'javascript.jsx': ['prettier', 'eslint'],
 \   'typescript': ['prettier', 'eslint'],
 \   'typescript.tsx': ['prettier', 'eslint'],
 \}
let g:ale_linters_ignore = {
 \   'typescript': ['tslint'],
 \   'typescript.tsx': ['tslint'],
 \}

if has("nvim")
  let g:deoplete#enable_at_startup = 1
  let g:LanguageClient_diagnosticsSignsMax = v:null
  let g:LanguageClient_loggingLevel = "Error"
  let g:LanguageClient_windowLogMessageLevel = "Error"
  let g:LanguageClient_serverCommands = {
  \   'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
  \   'sh': ['npx', 'bash-language-server', 'start'],
  \   'bash': ['npx', 'bash-language-server', 'start'],
  \   'javascript': ['npx', 'javascript-typescript-stdio'],
  \   'javascript.jsx': ['npx', 'javascript-typescript-stdio'],
  \   'typescript': ['npx', 'javascript-typescript-stdio'],
  \   'typescript.tsx': ['npx', 'javascript-typescript-stdio'],
  \}

  call deoplete#custom#option('sources', {
  \   '_': ['LanguageClient'],
  \})

  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
endif

function ToggleGutter()
  if &relativenumber
    set norelativenumber
    set signcolumn=no
  else
    set relativenumber
    set signcolumn=yes
  endif
endfunction

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-b> :Buffers<CR>
nmap <silent> <C-p> :GFiles<CR>
nmap <silent> <leader>p :Files<CR>
nmap <silent> <leader>g :call ToggleGutter()<CR>
nmap <silent> <leader>c :nohlsearch<CR>
nmap <silent> <leader>f :ALEFix<CR>

