" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd BufWinEnter * match ExtraWhitespace /\(\s\+$\)\|\(\t\+\)/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\(\s\+$\)\|\(\t\+\)/
autocmd InsertEnter * match ExtraWhitespace /\(\s\+\%#\@<!$\)\|\(\t\+\)/
autocmd BufWinLeave * call clearmatches()

function! s:FixWhitespace(line1,line2)
  let l:save_cursor = getpos(".")
  silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
  silent! execute ':' . a:line1 . ',' . a:line2 . 's/\t\+/  /g'
  silent! execute ':' . a:line1 . ',' . a:line2 . 'normal =='
  call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

map <leader>= :FixWhitespace<CR>
