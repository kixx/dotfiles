"
" Colors
"

colorscheme badwolf     " awesome colorscheme
syntax enable           " enable syntax processing

"
" Spaces & Tabs
"

set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces

"
" UI Config
"

set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files

set wildmenu            " visual autocomplete for command menu
set wildmode=list:full  " show list and complete first full match
set wildignore=*.sw?,*.bak,*~,
                        " ignore temp file for autocomplete
set lazyredraw          " redraw only when needed
set showmatch           " highlight matching {[()]}

"
" Searching
"

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set ignorecase          " ignore case on search
set smartcase           " case ignore with pattern is all lowercase, case sensitive otherwise

" tun off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"
" Folding
"

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes fold
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

"
" Movement
"

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

"
" Leader shortcuts
"

let mapleader=","       " leader is comma
" jk is escape
inoremap jk <esc>
" edit vimrc/bashrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag

" CtrlP settings
let g:ctrlp_match_window = 'bottom:order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -h ""'

"
" Launch Config
"

call pathogen#infect()                      " use pathogen
call pathogen#runtime_append_all_bundles()  " use pathogen

"
" Tmux
"

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"
" Other configs
"

set showmode                    " show the mode we're in
set nowrap                      " don't wrap lines
set backspace=indent,eol,start  " allow backspacing over everything
set autoindent                  " always autoindent
set copyindent                  " copy previous indent level on autindent
set shiftwidth=4                " indent with 4 spaces
set shiftround                  " indent with multiple of shiftwidth with < and >
set smarttab                    " insert tabs at beginning of line according to shift width not tab stop
set scrolloff=4                 " keep 4 lines above/below current line on screen
set gdefault                    " search/replace globally on line by default
set pastetoggle=<F2>            " toggle autoindent on paste on/off
set mouse=a                     " enable mouse if term supports it

" layout
set termencoding=utf-8
set encoding=utf-8

" behaviour
set hidden          " hide buffers
set history=1000    " remember more commands and search history
set undolevels=1000 " more undos
set undofile    " persisten undos
set undodir=~/.vim/undo,~/tmp,/tmp
set nobackup        " don't keep backupfiles
set noswapfile      " don't keep swapfiles

set title           " change term title
set visualbell      " don't beep
set noerrorbells    " don't beep

"
" KEYMAPS
"

" use ; as :
nnoremap ; :

" yank / paste to os clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" edit/reload vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" switch to last buffer
nnoremap <leader><leader> :e!#<cr>

"
" Autogroups
"
filetype plugin indent on

if has("autocmd")
    augroup vim_files
        au!

        " Bind <F1> to show help for the word under the cursor
        autocmd FileType vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd FileType vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end

    augroup html_files
        au!

        let g:closetag_default_xml=1
        autocmd FileType html,tt2,php let b:closetag_html_style=1
        autocmd FileType html,xhtml,xml,php source ~/.vim/bundle/closetag/plugin/closetag.vim
    augroup end

    augroup css_files
        au!

        autocmd FileType css,less setlocal foldmethod=marker foldmarker={,}
    augroup end

    augroup javascript_files
        au!

        autocmd FileType javascript setlocal expandtab
        autocmd FileType javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd FileType javascript setlocal foldmethod=marker foldmarker={,}
    augroup end

    augroup perl_files
        au!

        autocmd FileType perl setlocal makeprg=perl\ -c\ -MViQuickFix\ %
        autocmd FileType perl setlocal errorformat+=%m\ at\ %f\ line\ %l\.
        autocmd FileType perl setlocal errorformat+=%m\ at\ %f\ line\ %l
    " restore cursor postion when reopening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

endif

" extra vi-compatible options
set formatoptions-=o                    " don't start new lines with comment leader when pressing 'o'
au FileType vim set formatoptions-=o    " set again for vim files

" status
set laststatus=2
set statusline=%f%m%r%h%w\ [%{&ff}/%Y]\ %{fugitive#statusline()}\ [char=\%03.3b/0x\%02.2B]\ [%04l,%04v\ %p%%]\ [%L\ lines]

"
" PLUGIN CONFIGS
"

" fugitive
nnoremap <leader>g :Gstatus<CR>
