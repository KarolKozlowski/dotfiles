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
set wildmode=longest:full

" air-line setup
set laststatus=2
let g:airline_powerline_fonts = 1

" use syntax hiliting
syntax enable

" pathogen
execute pathogen#infect()

" syntastic
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check' " --no-class_parameter_defaults-check
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" text control:
set textwidth=80    " text width
set nowrap          " do not wrap long lines
set tabstop=4 shiftwidth=4 expandtab

" default encodings:
set encoding=utf-8
set fileencoding=utf-8

" color scheme:
"set t_Co=256
"let g:solarized_termcolors=256
"colorscheme solarized

set background=dark

if has("gui_running")
  colorscheme evening
  "Remove toolbar
  set guioptions-=T
else
  colorscheme ron
endif

" indentation
syntax on
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
filetype plugin indent on
set autoindent

" highliht tabs and trailing spaces:
autocmd syntax * SpaceHi
autocmd FileType help NoSpaceHi

" highlight current row:
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
set cursorline

" highlight current column:
"autocmd WinLeave * set nocursorcolumn
"autocmd WinEnter * set cursorcolumn
"set cursorcolumn

"Folding
set foldenable
set foldmethod=syntax
set foldnestmax=1

" Saves view into a file
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

autocmd BufNewFile,BufRead *.rb set filetype=ruby
autocmd BufNewFile,BufRead *.py set filetype=python



