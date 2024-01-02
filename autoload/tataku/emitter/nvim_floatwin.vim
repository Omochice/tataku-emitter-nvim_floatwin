let s:save_cpo = &cpo
set cpo&vim

augroup tataku#nvim_floatwin
  autocmd!
augroup END

let s:winid = -1
let s:BUFNAME = 'tataku-nvim_floatwin'

function! s:open(text, bufnr, options) abort
  let l:is_ended_with_empty_line = a:text[-1] =~# '^\s*$'
  call setbufvar(a:bufnr, '&buftype', 'nofile')
  " NOTE: if run without `silent` then echo `No lines in buffer`
  silent call deletebufline(a:bufnr, 1, '$')
  call setbufline(a:bufnr, 1, a:text)
  let l:width = [
        \ [
        \   a:text->map({_,v -> strdisplaywidth(v)})->max(),
        \   1
        \ ]->max(),
        \ &columns
        \ ]->min()
  let l:height = a:text->len() - (l:is_ended_with_empty_line ? 1 : 0)
  let l:options = {
        \ 'border': a:options.border,
        \ 'width': l:width,
        \ 'height': l:height,
        \ 'row': 0,
        \ 'col': 0,
        \ 'relative': 'cursor',
        \ 'style': 'minimal',
        \ }
  let s:winid = nvim_open_win(a:bufnr, v:false, l:options)
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

function! s:update(text, bufnr, options) abort
  let l:is_ended_with_empty_line = a:text[-1] =~# '^\s*$'
  let l:bufinfo = getbufinfo(s:BUFNAME)[0]
  let l:linenr = l:bufinfo.linecount
  let l:line = getbufline(a:bufnr, '$')[0] .. a:text[0]
  call setbufline(a:bufnr, l:linenr, l:line)
  if len(a:text) > 1
    call appendbufline(a:bufnr, l:linenr, a:text[1:])
  endif

  let l:wininfo = getwininfo(s:winid)[0]
  let l:textwidth = [
        \ a:text->map({_,v -> strdisplaywidth(v)})->max(),
        \ l:line->len(),
        \ l:wininfo.width
        \ ]->max()
  let l:width = [
        \ l:textwidth,
        \ &columns,
        \ ]->min()
  let l:height = getbufinfo(s:BUFNAME)[0].linecount - (l:is_ended_with_empty_line ? 1 : 0)
  call nvim_win_set_width(s:winid, l:width)
  call nvim_win_set_height(s:winid, l:height)
endfunction

function! tataku#emitter#nvim_floatwin#open(text, options) abort
  let l:magic = &magic
  let &magic = v:true
  let l:bufnr = bufnr(s:BUFNAME, v:true)
  call bufload(l:bufnr)
  if getwininfo(s:winid)->empty()
    call s:open(a:text, l:bufnr, a:options)
  else
    call s:update(a:text, l:bufnr, a:options)
  endif
  let &magic = l:magic
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
