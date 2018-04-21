" Vundle
if isdirectory(expand($HOME . '/.vim/bundle/Vundle.vim/'))
    filetype off
    set nocompatible
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
        Plugin 'VundleVim/Vundle.vim'
        " Plugins
        Plugin 'airblade/vim-gitgutter'
        Plugin 'bling/vim-airline'
        Plugin 'kien/ctrlp.vim'
        Plugin 'mattn/emmet-vim'
        Plugin 'plasticboy/vim-markdown'
        Plugin 'tpope/vim-commentary'
        Plugin 'tpope/vim-eunuch'
        Plugin 'w0rp/ale'
        Plugin 'nvie/vim-flake8'
        Plugin 'tpope/vim-sleuth'
        Plugin 'sheerun/vim-polyglot'
        " Themes
        Plugin 'altercation/vim-colors-solarized'
        Plugin 'vim-airline/vim-airline-themes'
    call vundle#end()
endif

" Disable mouse
set mouse=

" Disable backups
set nobackup
set noswapfile
set nowritebackup

" Disable viminfo
set viminfo=

" Replace tabs for spaces
set expandtab
set shiftwidth=4
set tabstop=4

" Indentation and syntax
filetype plugin indent on
set autoindent
syntax on
" Indentation settings per file type
au FileType javascript setl sw=2 ts=2 et
au FileType json setl sw=2 ts=2 et
au FileType yaml setl sw=2 ts=2 et

" Viewing options, like cursor position and number of lines
set cursorline
set linebreak
set number
set ruler
set wildmenu

" Fix ESC delay
set ttimeoutlen=0

" Toggle hidden characters
map <silent> <C-m> :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Navigation between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Navigation between tabs
map <Tab> gt
map <S-Tab> gT

" Search options
set hlsearch
set ignorecase
set incsearch

" Clear search results highlights
nmap <silent> <C-C> :silent noh<CR>

" File encoding
set encoding=utf-8

" Omnicomplete
inoremap <Nul> <C-x><C-o>

" Close preview window automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Settings per plugin/theme
if isdirectory(expand($HOME . '/.vim/bundle/Vundle.vim/'))
    if isdirectory(expand($HOME . '/.vim/bundle/vim-colors-solarized/'))
        if has('gui_running')
            set background=light
        else
            set background=dark
        endif
        let g:solarized_termcolors=256
        set t_Co=256
        colorscheme solarized
        " Fix spell checker highlighting
        hi SpellBad cterm=underline
    endif

    if isdirectory(expand($HOME . '/.vim/bundle/ctrlp.vim/'))
        if executable('ag')
            let g:ctrlp_user_command = 'ag %s -g ""'
        endif
    endif

    if isdirectory(expand($HOME . '/.vim/bundle/vim-airline/'))
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
        let g:airline_theme = 'powerlineish'
        set laststatus=2
    endif

    if isdirectory(expand($HOME . '/.vim/bundle/vim-markdown/'))
        let g:vim_markdown_folding_disabled=1
    endif
endif

" Auto-complete com a tecla Tab
function! Tab_Or_Complete()
    if col('.') > 1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" Posiciona cursor no primeiro caractere da linha
map 0 ^

" Define largura do texto
set textwidth=120

" Exibe linha vertical
:set cursorcolumn

" Função para remover espaços ao final da linha
function! RemoveEspacoFinalLinha()
    silent! :%s/\s*$//g
    silent! noh
endfunction
map <C-n> :call RemoveEspacoFinalLinha()<CR>
