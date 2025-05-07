" --------------------------------
" 1. Vim Options
" --------------------------------
" Set leader key to spacebar
let mapleader = "\<Space>"
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" Set termguicolors if terminal supports
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Changing cursor style
if has('gui_running')
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
endif

set nocompatible
syntax enable
filetype plugin indent on
set number
set relativenumber
set numberwidth=1
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
set updatetime=300
set shortmess+=c
set expandtab
set ttimeoutlen=1

" List chars
set list
set listchars=trail:·,extends:>,precedes:<,space:·
" space:·

" --------------------------------
" 2. Plugins
" --------------------------------
" Install vim-plug if not found
"
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

" Git plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Advanced linter analysis
Plug 'dense-analysis/ale'

" Commentary
Plug 'tpope/vim-commentary'

" Vim-Grepper
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

" Path completions
Plug 'prabirshrestha/asyncomplete-file.vim'

" Color Scheme
Plug 'EdenEast/nightfox.nvim'

" Vim-visual-multi
Plug 'mg979/vim-visual-multi'

" Vim-indent-guides
Plug 'nathanaelkane/vim-indent-guides'

" Vim-instant-markdown
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

call plug#end()

" --------------------------------
" 3. Plugin Configurations
" --------------------------------
" Theme
set background=dark
colorscheme terafox

" Reduce brightness of listchars
highlight NonText ctermfg=8 guifg=#5c6370   " For invisible characters
highlight SpecialKey ctermfg=8 guifg=#5c6370 " For special keys like tab
highlight Whitespace ctermfg=8 guifg=#5c6370 " For spaces and other invisible chars

" Vim-indent-guides enable on startup
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']

" Enable vim-gitgutter
let g:gitgutter_enabled = 1

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Vim-airline
" ALE settings
let g:ale_linters = {
            \ 'c'          : ['clang'],
            \ 'cpp'        : ['clang'],
            \ 'vim'        : ['vint'],
            \ 'python'     : ['pylint'],
            \ 'javascript' : ['eslint'],
            \ 'css'        : ['stylelint'],
            \ 'html'       : ['htmlhint'],
            \ 'lua'        : ['luacheck'],
            \ 'tex'        : ['chktex'],
            \ }

let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['black'],
            \ 'javascript': ['prettier'],
            \ 'css': ['prettier'],
            \ 'html': ['prettier'],
            \ }

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '∆'
let g:ale_sign_info = 'ℹ'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_virtualtext_cursor = 1
let g:ale_hover_to_preview = 1

highlight ALEError ctermbg=DarkGray guibg=DarkGray
highlight ALEWarning ctermbg=DarkGray guibg=DarkGray
let g:ale_set_highlights = 1

" FZF settings
" let $FZF_DEFAULT_COMMAND = "ag --hidden --ignore .git -p ~/.gitignore -g ''"
" Fixed fzf load command
let $FZF_DEFAULT_COMMAND=""
let $FZF_PREVIEW_COMMAND = 'cat {}'
let g:fzf_preview_window = ['right', 'ctrl-i']
nnoremap <C-p> :call FZFOpen(':Files')<CR>
nnoremap <C-q> :call FZFOpen(':Buffers')<CR>
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

" " Livegrep Telescope feature
" command! -nargs=* Rg call fzf#vim#grep(
"             \ 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!{.git/**}" '.shellescape(<q-args>). ' .', 1,
"             \ fzf#vim#with_preview(), <bang>0)
" nnoremap <Leader>fg :Rg<CR>

" Vim-grepper configuration
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']
let g:grepper.highlight = 1
let g:grepper.quickfix = 1
let g:grepper.jump = 0

" Modified preview function to properly handle cursor movement
function! PreviewQuickfixLine()
    " Don't do anything if we're not in the quickfix window
    if &filetype != 'qf'
        return
    endif

    let l:list = getqflist()
    if len(l:list) == 0
        return
    endif

    " Get current quickfix item
    let l:curr_item = l:list[line('.') - 1]

    " Find the window that has the buffer
    let l:winid = win_getid()
    wincmd p

    " Jump to the location
    call cursor(l:curr_item.lnum, l:curr_item.col)
    normal! zz

    " Go back to quickfix window
    call win_gotoid(l:winid)
endfunction

" Set up the autocommand for cursor movement
autocmd FileType qf autocmd CursorMoved <buffer> call PreviewQuickfixLine()

" Open quickfix with focus after grep
autocmd User Grepper botright copen

" Your existing mappings
nnoremap <leader>gg :Grepper<cr>
nnoremap <leader>fg :Grepper -buffer<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <leader>* :Grepper -cword -noprompt<cr>

" ----------------------------------------------------------

" Vim-Visual-Multi
" Disable default mappings
let g:VM_default_mappings = 0
" Custom mappings
let g:VM_maps = {'Find Under': ''}
" Add cursor at position without mappings
let g:VM_add_cursor_at_pos_no_mappings = 1

" Visual cursors with delay
function! VisualCursorsWithDelay()
    silent! normal! \<Plug>(VM-Visual-Cursors)
    sleep 200m
    silent! normal! A
endfunction

" Set up mappings
nmap <silent> <leader>ma <Plug>(VM-Select-All)
nmap <silent> <leader>mr <Plug>(VM-Start-Regex-Search)
nmap <silent> <leader>mp <Plug>(VM-Add-Cursor-At-Pos)
vmap <silent> <leader>mc :call VisualCursorsWithDelay()<CR>
nmap <silent> <leader>mo <Plug>(VM-Toggle-Mappings)

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

" LSP
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_semantic_enabled = 1

" LSP highlighting groups
" highlight lspReference ctermfg=Darkgray guifg=Darkgray ctermbg=green guibg=green
" highlight LspErrorText ctermfg=DarkGray guifg=DarkGray
" highlight LspWarningText ctermfg=Yellow guifg=Yellow
" highlight LspInformationText ctermfg=Blue guifg=Blue
" highlight LspHintText ctermfg=Green guifg=Green

" Additional ALE settings
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1

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
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

if executable('clangd')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'clangd',
                \ 'cmd': {server_info->['clangd', '-background-index']},
                \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                \ })
endif

" --------------------------------
" 4. Plugin Keymaps
" --------------------------------
" Custom keymaps
let g:startify_custom_header = [
            \ '                                 ',
            \ '            __                   ',
            \ '    __  __ /\_\    ___ ___       ',
            \ '   /\ \/\ \\/\ \ /'' __` __`\    ',
            \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \    ',
            \ '    \ \___/  \ \_\ \_\ \_\ \_\   ',
            \ '     \/__/    \/_/\/_/\/_/\/_/   ',
            \ ]

" For closing all the files in the buffers except the current one
nnoremap <Leader>xx :w <bar> %bd <bar> e# <bar> bd# <CR>

" Move the current window in new vertical split window
nnoremap <leader>mv :vsplit<CR>:b#<CR>

" namvigate through pages
nnoremap <Leader>kk zzHzz
nnoremap <Leader>jj zzHzz

" Cycle through buffers
noremap <C-h> :bprev<CR>
noremap <C-l> :bnext<CR>

" Change window focous
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l


" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" Git
nnoremap <leader>gs :vert Git<CR>
nnoremap <leader>gd :vert Gdiff<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gP :Git push -f origin main<CR>
nnoremap <leader>gl :vert Git log --oneline<CR>
nnoremap <leader>ga :Git commit --amend<CR>
nnoremap <leader>gn :Git commit --amend --no-edit<CR>

" Show last commit detials
function! ShowLastCommit()
    let file = expand('%:p')
    let git_command = 'git log -1 --oneline -- ' . shellescape(file)
    let commit_hash = system(git_command)
    " if v:shell_error != 0
    "     echoerr "Git command failed. Error: " . v:shell_error
    "     echoerr "Command: " . git_command
    "     echoerr "Output: " . commit_hash
    "     return
endif
if empty(commit_hash)
    echoerr "No commit information available for file: " . file
    return
endif
" Remove newline character from commit_hash
let commit_hash = substitute(commit_hash, '\n', '', 'g')
" Extract just the hash part (first 7 characters)
let short_hash = strpart(commit_hash, 0, 7)
" Open a new vertical split and run :Git show
try
    " execute 'vertical new'
    execute ':vert Git show ' . short_hash
    " Set the buffer as non-modifiable
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nomodifiable
catch
    echoerr "Failed to show commit. Error: " . v:exception
endtry
endfunction

nnoremap <leader>lc :call ShowLastCommit()<CR>

" --------------------------------
" 5. Autocmds
" --------------------------------
" Automatically source .vimrc on save
augroup vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

autocmd BufWritePre * %s/\s\+$//e   " Remove trailing spaces

" Set indentation for specific file types
autocmd FileType python setlocal shiftwidth=4 softtabstop=4
autocmd FileType lua setlocal shiftwidth=4 softtabstop=4
autocmd FileType c setlocal shiftwidth=4 softtabstop=4
autocmd FileType java setlocal shiftwidth=4 softtabstop=4

" Syntax highlighting for (markdown).md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Highlight the MatchParen group
highlight MatchParen gui=bold guibg=darkblue guifg=lightblue
