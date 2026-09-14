"~/.vimrc by Karol Kozlowski

set backup           " write a ~ backup copy next to the file before overwriting it, so edits can be recovered
set history=50       " remember the last 50 : commands and / search patterns for this session
set ruler            " always show the cursor's line/column position in the status line
set showcmd          " echo partially typed commands (e.g. "2d") in the bottom right while typing
set incsearch        " jump to search matches as you type, before pressing Enter
set number           " show absolute line numbers in the left gutter
set hlsearch         " highlight all matches of the last search pattern until :nohlsearch
set pastetoggle=<F2> " F2 toggles 'paste' mode, disabling auto-indent/expandtab so pasted text isn't mangled
set wildmenu         " show a menu of possible completions above the command line on <Tab>
set modeline         " allow files to set local options via a "vim: ..." line near the top/bottom
set wildmode=longest:full " complete the longest common prefix first, then cycle full matches on repeated <Tab>

" pathogen: load third-party plugins from .vim/bundle/ (legacy plugin manager)
execute pathogen#infect()

"Remove dollar sign from EOL
set lcs=eol:\  " listchars: show a plain space instead of the default '$' at each end-of-line

" use syntax hiliting
syntax enable " turn on syntax highlighting without overriding colors set elsewhere (see 'syntax on' below)

"Text control:
set textwidth=80    " wrap column used by gq/gw and 'formatoptions' (long lines aren't hard-wrapped automatically, see nowrap)
set nowrap          " display long lines on one row, scrolling sideways, instead of soft-wrapping them
set tabstop=4       " a literal <Tab> character is displayed as 4 columns wide
set softtabstop=4   " <Tab>/<BS> insert/remove 4 columns worth of whitespace while editing
set shiftwidth=4    " indent commands (>>, <<, autoindent) shift by 4 columns
set expandtab       " insert spaces instead of a literal <Tab> character

" visual bell
set visualbell " flash the screen instead of beeping on errors

"Default encodings:
set encoding=utf-8     " internal/display character encoding used by vim itself
set fileencoding=utf-8 " encoding used when writing files to disk

set laststatus=2 " always show the status line, even with a single window (needed for airline)
let g:airline_powerline_fonts = 0 " disable powerline glyphs by default (only turned on below for 256-color xterm)

"Color scheme:
set background=dark " tell vim/colorschemes the terminal background is dark, for correct contrast
if has("gui_running")
    colorscheme evening " GUI (gvim) colorscheme
    "Remove toolbar
    set guioptions-=T " hide the GUI toolbar
    " only on xterm
    if has("terminfo")
        set t_Co=256 " tell vim the terminal supports 256 colors
        let g:solarized_termcolors=256 " make solarized use the 256-color palette instead of the terminal's ANSI colors
        colorscheme solarized " use solarized when running the GUI under a 256-color xterm
        " load airline:
        let g:airline_powerline_fonts = 1 " enable powerline glyphs for airline in this case

    endif
else
  "colorscheme evening
  "colorscheme ron
  colorscheme dracula " terminal (non-GUI) colorscheme
endif

" extend path on WIN
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after " rebuild 'runtimepath' so ~/.vim is used on Windows like ~/.vim is on Unix
endif

"Syntax highlighting and indentation
syntax on " enable syntax highlighting (also loads filetype-specific syntax files)
filetype plugin indent on " enable filetype detection plus per-filetype plugins and indent rules
set smartindent " C-like auto-indent: indent after {, un-indent after }, etc.
set autoindent  " copy the indent of the current line when starting a new one

"Highliht tabs and trailing spaces:
autocmd syntax * SpaceHi        " highlight tabs/trailing whitespace (SpaceHi plugin) whenever syntax is (re)loaded
autocmd FileType help NoSpaceHi " ...except in :help buffers, where it's just noise

" detect ks.cfg as kickstart file
au BufRead,BufNewFile ks.cfg setfiletype kickstart " treat kickstart config files as filetype 'kickstart' for syntax highlighting

" Python specific settings
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 " enforce PEP8-style 4-space indentation specifically for python

" highlight current row:
autocmd WinLeave * set nocursorline " turn off the cursor line highlight in windows that lose focus
autocmd WinEnter * set cursorline   " turn it back on in the window that gains focus
set cursorline                      " highlight the line the cursor is on, in the current window

"Highlight current row and column:
autocmd WinLeave * set nocursorline nocursorcolumn " (duplicate/overriding block) also clear cursorcolumn on losing focus
"autocmd WinEnter * set cursorcolumn " (left disabled) would highlight the cursor's column too
autocmd WinEnter * set cursorline   " re-enable cursorline on gaining focus
"set cursorcolumn " (left disabled) always-on column highlight
set cursorline    " (redundant with the block above) ensure cursorline stays on

"Folding
set foldenable          " allow folds to be closed
set foldmethod=syntax   " derive folds from syntax highlighting rules
set foldnestmax=1       " only allow one level of nested folds, keeps things simple

" Saves view into a file
autocmd BufWinLeave * silent! mkview   " save cursor position/folds/options for the buffer's window when it's closed
autocmd BufWinEnter * silent! loadview " restore that saved view when the buffer is opened again in a window

autocmd BufNewFile,BufRead *.rb set filetype=ruby   " force filetype for .rb files (belt-and-braces, usually auto-detected already)
autocmd BufNewFile,BufRead *.py set filetype=python " same for .py files

set nocp " run vim in its own improved mode instead of vi-compatible mode (usually already the default once a vimrc is found)

" syntastic
set statusline+=%#warningmsg#                  " status line: switch to the warning highlight group...
set statusline+=%{SyntasticStatuslineFlag()}    " ...to show syntastic's error/warning summary...
set statusline+=%*                              " ...then switch back to the default highlight group

let enable_syntastic = 1 " master on/off switch for syntastic, computed below
if getwinvar(0, '&diff')
    " disable syntastic in vimdiff
    let enable_syntastic = 0 " don't run linters while reviewing a diff
endif

let g:syntastic_check_on_open = 1            " (overridden below) run checks when a file is opened
let g:syntastic_check_on_wq = 1              " also lint on :wq
let g:syntastic_always_populate_loc_list = 1 " (overridden below) always fill the location list with lint results
let g:syntastic_auto_loc_list = 1            " (overridden below) automatically open/close the location list window

let g:syntastic_always_populate_loc_list = enable_syntastic " re-apply, gated on whether we're in a diff
let g:syntastic_auto_loc_list = enable_syntastic            " same
let g:syntastic_check_on_open = enable_syntastic            " same

let g:syntastic_puppet_puppetlint_args = '--no_class_inherits_from_params_class-check --no-80chars-check' " suppress specific puppet-lint checks
let g:syntastic_python_flake8_post_args = '--ignore=E501' " ignore flake8's line-too-long warning (textwidth=80 is only a soft guide)

" make vim window transparrent in windows terminal
autocmd vimenter * ++nested highlight Normal ctermbg=NONE guibg=NONE " use the terminal's own background instead of the colorscheme's, for transparency

