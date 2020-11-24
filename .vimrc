"~/.vimrc by Karol Kozlowski

set backup          " keep a backup file
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching by deafult
set number          " show line numbers
set hlsearch        " highlight search
set paste           " paste mode
set wildmenu        " show tab-completion matches in command line
set modeline        " enable modeline
set wildmode=longest:full

"Remove dollar sign from EOL
set lcs=eol:\ 

" use syntax hiliting
syntax enable

"Text control:
set textwidth=80    " text width
set nowrap          " do not wrap long lines
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" visual bell
set visualbell

"Default encodings:
set encoding=utf-8
set fileencoding=utf-8

set laststatus=2
let g:airline_powerline_fonts = 0

"Color scheme:
set background=dark
if has("gui_running")
    colorscheme evening
    "Remove toolbar
    set guioptions-=T
    " only on xterm
    if has("terminfo")
        set t_Co=256
        let g:solarized_termcolors=256
        colorscheme solarized
        " load airline:
        let g:airline_powerline_fonts = 1
    endif
else
  "colorscheme evening
  colorscheme ron
endif

" extend path on WIN
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

"Syntax highlighting and indentation
syntax on
filetype plugin indent on
set autoindent

"Highliht tabs and trailing spaces:
autocmd syntax * SpaceHi
autocmd FileType help NoSpaceHi

" detect ks.cfg as kickstart file
au BufRead,BufNewFile ks.cfg setfiletype kickstart

" Python specific settings
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4

" highlight current row:
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
set cursorline

"Highlight current row and column:
autocmd WinLeave * set nocursorline nocursorcolumn
"autocmd WinEnter * set cursorcolumn
autocmd WinEnter * set cursorline
"set cursorcolumn
set cursorline

"Folding
set foldenable
set foldmethod=syntax
set foldnestmax=1

" Saves view into a file
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

autocmd BufNewFile,BufRead *.rb set filetype=ruby
autocmd BufNewFile,BufRead *.py set filetype=python

set nocp

" pathogen
execute pathogen#infect()

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let enable_syntastic = 1
if getwinvar(0, '&diff')
    " disable syntastic in vimdiff
    let enable_syntastic = 0
endif

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:syntastic_always_populate_loc_list = enable_syntastic
let g:syntastic_auto_loc_list = enable_syntastic
let g:syntastic_check_on_open = enable_syntastic
let g:syntastic_check_on_wq = 0

let g:syntastic_puppet_puppetlint_args = '--no_class_inherits_from_params_class-check --no-80chars-check'
