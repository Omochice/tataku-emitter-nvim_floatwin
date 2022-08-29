let s:save_cpo = &cpo
set cpo&vim

augroup tataku#nvim_floatwin
  autocmd!
augroup END

function! tataku#emitter#nvim_floatwin#open(text, options) abort
  let l:bufname = "tataku-nvim_floatwin"
  let l:bufnr = bufnr(l:bufname, v:true)

  call bufload(l:bufnr)
  call setbufvar(l:bufnr, '&buftype', 'nofile')
  " NOTE: if run without `silent` then echo `No lines in buffer`
  silent call deletebufline(l:bufnr, 1, '$')
  call setbufline(l:bufnr, 1, a:text)
  let l:options = {
        \ 'border': a:options.border,
        \ 'width': min([max(map(a:text, {_,v -> strdisplaywidth(v) })), &columns]),
        \ 'height': len(a:text),
        \ 'row': 0,
        \ 'col': 0,
        \ 'relative': 'cursor',
        \ 'style': 'minimal',
        \ }
  let s:winid = nvim_open_win(l:bufnr, v:false, l:options)

  let l:curpos = getcurpos()
  let s:line = l:curpos[1]
  let s:col = l:curpos[2]

  if a:options.autoclose
    " NOTE: is giving `s:winid` redundant?
    augroup tataku#nvim_floatwin
      autocmd CursorMoved,CursorMovedI,WinEnter * call s:close(s:winid)
    augroup END
  endif
endfunction

function! s:close(winid) abort
  let l:curpos = getcurpos()
  if s:line !=# l:curpos[1] || s:col !=# l:curpos[2]
    call nvim_win_close(a:winid, v:false)
    augroup tataku#nvim_floatwin
      autocmd!
    augroup END
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
