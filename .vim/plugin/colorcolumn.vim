function! ToggleColorColumn()
  if &colorcolumn == "+1"
    set colorcolumn=
  else
    set colorcolumn=+1
  endif
endfunction

com! ToggleColorColumn call ToggleColorColumn()

highlight ColorColumn ctermbg=darkblue guibg=darkblue

