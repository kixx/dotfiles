" enable UTF-8 characters
scriptencoding utf-8
set encoding=utf-8

" disable backward vi compatibility
set nocompatible

" pathogen (includes plugins in bundle/)
call pathogen#infect()

" replace mapleader "\" with ","
let mapleader=","

" common stuff
set showmode        " show the mode we're in
set nowrap          " don't wrap lines
set tabstop=4       " tabs are 4 spaces
set expandtab       " expand tabs to spaces
set softtabstop=4   " remove spaces as they were tabs
set backspace=indent,eol,start
                    " allow backspacing over everything
set autoindent      " always autoindent
set copyindent      " copy previous indent level on autindent
set shiftwidth=4    " indent with 4 spaces
set shiftround      " indent with multiple of shiftwidth with < and >
set showmatch       " show matching parens
set ignorecase      " ignore case on search
set smartcase       " case ignore with pattern is all lowercase,
                    "  case sensitive otherwise
set smarttab        " insert tabs at beginning of line according
                    " to shift width not tab stop
set scrolloff=4     " keep 4 lines above/below current line on screen
set hlsearch        " highlight searches
set incsearch       " show searches as you type
set gdefault        " search/replace globally on line by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
                    " markers for invisible chars
set nolist          " don't show invisible chars by default 
                    " but we'll override it later for some file types
set pastetoggle=<F2> " toggle autoindent on paste on/off
set mouse=a         " enable mouse if term supports it

" layout
set termencoding=utf-8
set encoding=utf-8
set lazyredraw      " don't update display when executing macros
set laststatus=2    " always display statusbar

" behaviour
set hidden          " hide buffers
set history=1000    " remember more commands and search history
set undolevels=1000 " more undos
if v:version >= 730
    set undofile    " persisten undos
    set undodir=~/.vim/undo,~/tmp,/tmp
endif
set nobackup        " don't keep backupfiles
set noswapfile      " don't keep swapfiles

set wildmenu        " autocomplete"
set wildmode=list:full " show list and complete first full match"
set wildignore=*.sw?,*.bak,*~,
                    " ignore temp file for autocomplete
set title           " change term title
set visualbell      " don't beep
set noerrorbells    " don't beep
set showcmd         " show partial command and visual selection info
"set cursorline      " highlight current line



"
" COLORS
"

if &t_Co > 2 || has("gui_running")
    syntax on
    colorscheme kixx
    set background=dark
"    colorscheme solarized
endif


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

" clear search buffer
nmap <silent> <leader>/ :nohlsearch<CR>

" quickly get out of insert mode with jj
inoremap jj <Esc>

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" switch to last buffer
nnoremap <leader><leader> :e!#<cr>

"
" FILE TYPES
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
set formatoptions-=o " don't start new lines with comment leader 
                     " when pressing 'o'
au FileType vim set formatoptions-=o " set again for vim files"""

" status
set laststatus=2
set statusline=%f%m%r%h%w\ [%{&ff}/%Y]\ [char=\%03.3b/0x\%02.2B]\ [%04l,%04v\ %p%%]\ [%L\ lines]

"
" PLUGIN CONFIGS
"

" supertab
let g:SuperTabLongestEnhanced=1

" tagbar
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" buffergator
let g:buffergator_viewport_split_policy = "R"
let g:buffergator_display_regime="bufname"

" fugitive
nnoremap <leader>g :Gstatus<CR>
