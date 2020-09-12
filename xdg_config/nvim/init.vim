if has('nvim')
  let plugdir = stdpath('data') . '/plugged'
else
  let plugdir = '~/.local/share/vim/plugged'
endif

call plug#begin(plugdir)

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'

Plug 'cespare/vim-toml'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'

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

set signcolumn=yes
set hidden
set relativenumber
set ignorecase
set smartcase
set incsearch

set termguicolors
colorscheme gruvbox
set background=dark

let g:airline_theme = 'gruvbox'
let g:vimwiki_list = [{'path': '~/.dotdata/vimwiki/'}]
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer',
  \ 'coc-json',
  \ 'coc-svelte',
  \ 'coc-prettier',
  \ 'coc-eslint'
  \ ]

function ToggleGutter()
  if &relativenumber
    set norelativenumber
    set signcolumn=no
  else
    set relativenumber
    set signcolumn=yes
  endif
endfunction

nmap <silent> <C-b> :Buffers<CR>
nmap <silent> <C-p> :GFiles<CR>
nmap <silent> <leader>p :Files<CR>
nmap <silent> <leader>g :call ToggleGutter()<CR>
nmap <silent> <leader>c :nohlsearch<CR>




" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>do <Plug>(coc-codeaction)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
