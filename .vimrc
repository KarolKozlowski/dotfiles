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

"Text control:
set textwidth=80    " text width
set nowrap          " do not wrap long lines
set tabstop=2 shiftwidth=2 expandtab

set background=dark

set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized

if has("gui_running")
  set guioptions-=T
endif

" indentation
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
filetype plugin indent on
set autoindent

"Highliht tabs and trailing spaces:
autocmd syntax * SpaceHi
autocmd FileType help NoSpaceHi

"Highlight current row:
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
set cursorline

"Highlight current column:
"autocmd WinLeave * set nocursorcolumn
"autocmd WinEnter * set cursorcolumn
"set cursorcolumn

"key bindings
map <silent> <unique> <F2>  :w<CR>
map <silent> <unique> <F10> :q<CR>

map <silent> <unique> <C-t>t :tabnew<CR>
map <silent> <unique> <C-t>n :tabn<CR>
map <silent> <unique> <C-t>p :tabp<CR>

