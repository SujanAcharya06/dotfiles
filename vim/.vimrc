" --------------------------------
" 1. Vim Options
" --------------------------------
" Set leader key to spacebar
let mapleader = "\<Space>"

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set nocompatible
syntax enable
filetype plugin indent on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set autoindent
set wrap
set linebreak
set incsearch
set hlsearch
set ignorecase
set smartcase
set splitbelow
set splitright
set hidden
set mouse=a
set clipboard=unnamedplus
set backspace=indent,eol,start
set wildmenu
set wildmode=list:longest,full
set laststatus=2
set showcmd
set showmatch
set visualbell
set t_vb=
set updatetime=500
set shortmess+=I

" Time delay on <Leader> key
set timeoutlen=3000 ttimeoutlen=100

" --------------------------------
" 2. Plugins
" --------------------------------
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin('~/.vim/plugged')

" Startify
Plug 'mhinz/vim-startify'

" Themes
Plug 'morhetz/gruvbox'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LSP config
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" NERDTree
Plug 'preservim/nerdtree'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Surround plugin
Plug 'tpope/vim-surround'

" vim-bufferline
Plug 'bling/vim-bufferline'

" Git plugins
Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Advanced linter analysis
Plug 'dense-analysis/ale'

" Commentary
Plug 'tpope/vim-commentary'

"" Path completions
Plug 'prabirshrestha/asyncomplete-file.vim'

" Color Scheme
Plug 'EdenEast/nightfox.nvim'
call plug#end()

" --------------------------------
" 3. Plugin Keymaps
" --------------------------------
" Custom keymaps
let g:startify_custom_header = [
            \ '                              ',
            \ '            __                ',
            \ '    __  __ /\_\    ___ ___    ',
            \ '   /\ \/\ \\/\ \ /'' __` __`\ ',
            \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \ ',
            \ '    \ \___/  \ \_\ \_\ \_\ \_\',
            \ '     \/__/    \/_/\/_/\/_/\/_/',
            \ ]

" For closing all the files in the buffers except the current one
nnoremap <Leader>xx :w <bar> %bd <bar> e# <bar> bd# <CR>

" Move the current window in new vertical split window
nnoremap <leader>mv :vsplit<CR>:b#<CR>

" Cycle through buffers
noremap <C-h> :bprev<CR>
noremap <C-l> :bnext<CR>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" Git
nnoremap <leader>gs :vert Git<CR>
nnoremap <leader>gd :vert Gdiff<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>P :Git push<CR>
nnoremap <leader>gl :vert Git log --oneline<CR>

" --------------------------------
" 4. Autocmds
" --------------------------------
" Automatically source .vimrc on save
augroup vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Remove trailing whitespace on save
" autocmd BufWritePre * %s/\s\+$//e

" Set indentation for specific file types
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType lua setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType c setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType java setlocal expandtab shiftwidth=4 softtabstop=4

" Syntax highlighting for (markdown).md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" --------------------------------
" 5. Plugin Configurations
" --------------------------------
" Theme
colorscheme nightfox 
set background=dark

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" ALE settings
let g:ale_linters = {
            \ 'c'          : ['clang'],
            \ 'cpp'        : ['clang'],
            \ 'vim'        : ['vint'],
            \ 'python'     : ['pylint'],
            \ 'javascript' : ['jshint'],
            \ 'css'        : ['csslint'],
            \ 'tex'        : ['chktex'],
            \ }

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '∆'
let g:ale_sign_info = 'ℹ'

" FZF settings
" let $FZF_DEFAULT_COMMAND = "ag --hidden --ignore .git -p ~/.gitignore -g ''"
" Fixed fzf load command
let $FZF_DEFAULT_COMMAND=""
let $FZF_PREVIEW_COMMAND = 'cat {}'
let g:fzf_preview_window = ['right', 'ctrl-i']
nnoremap <leader>fg :call FZFOpen(':Files')<CR>
nnoremap <C-p> :call FZFOpen(':Buffers')<CR>
nnoremap <Leader>gz :Commits<CR>
nnoremap <Leader>uh :History<CR>
" nnoremap <Leader>ul :BLines<CR>
nnoremap <Leader>ut :Tags<CR>
nnoremap <Leader>uu :BTags<CR>
nnoremap <silent><Leader>uf
            \ :call fzf#vim#buffer_tags('',
            \ { 'options': ['--nth', '..-2,-1', '--query', '^f$ ']  })<CR>
nnoremap <silent><Leader>uv
            \ :call fzf#vim#buffer_tags('',
            \ { 'options': ['--nth', '..-2,-1', '--query', '^v$ ']  })<CR>

" Navigate between errors
nnoremap <Leader>h :lprevious<CR>zz
nnoremap <Leader>l :lnext<CR>zz

" Fix FZF opening window in NERD tree buffer.`vim .` issue
" function! FZFOpen(command_str)
"   if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
"     exe "normal! \<c-w>\<c-w>"
"   endif
"   exe 'normal! ' . a:command_str . "\<cr>"
" endfunction


function! FZFOpen(command_str)
    "Defint the predefined directory
    let predefined_directory = getcwd() "'~/Documents'  Set to Documents to reduce search time
    if expand('%') =~# 'NERD_tree' && winnr('$') > 1
        " Switch to the next window if NERDTree is open and there are other windows
        exe "normal! \<c-w>\<c-w>"
        " Check if current buffer is NERDTree and it's the only open window
    elseif expand('%') =~# 'NERD_tree' && winnr('$') == 1
        let current_file = expand('%')
        " Open new window for fzf command
        exe "new"
        " Open the selected file in the new window
        exe 'edit ' . fnameescape(current_file)
        " Delete any 'No Name' buffer that might have been created
        %bd
    endif

    " Temporarily change the directory to the predefined path
    let current_cwd = getcwd()
    execute 'cd ' . predefined_directory

    try
        " Execute the provided command_str
        exe 'normal! ' . a:command_str . "\<cr>"
    finally
        execute 'cd ' . current_cwd
    endtry
endfunction

" LSP Configuration
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Asyncomplete Configuration
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview

" Register asyncomplete sources
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'allowlist': ['*'],
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ 'config': {
                \    'max_buffer_size': 5000000,
                \  },
                \ }))

call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
            \ 'name': 'omni',
            \ 'allowlist': ['*'],
            \ 'blocklist': ['html'],
            \ 'completor': function('asyncomplete#sources#omni#completor'),
            \ 'config': {
                \   'show_source_kind': 1
                \ }
                \ }))

" Configure file path completion
call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'allowlist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))

" Enable asyncomplete for command-line mode
autocmd CmdlineEnter * call asyncomplete#enable_for_buffer()

" Automatically close preview window after completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use Tab to navigate completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Enable LSP for specific languages (adjust as needed)
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'allowlist': ['python'],
                \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'clangd',
                \ 'cmd': {server_info->['clangd', '-background-index']},
                \ 'allowlist': ['c',  'objc'], 
                \ 'blocklist': ['cpp', 'objcpp'],
                \ })
endif

" HTML LSP
if executable('html-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'html-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
        \ 'allowlist': ['html'],
        \ })
endif

" CSS LSP
if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'allowlist': ['css', 'less', 'sass', 'scss'],
        \ })
endif

" Lua LSP
if executable('lua-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'lua-language-server',
        \ 'cmd': {server_info->['lua-language-server']},
        \ 'allowlist': ['lua'],
        \ })
endif
