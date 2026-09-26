if exists('g:loaded_tataku_emitter_nvim_floatwin')
  finish
endif
let g:loaded_tataku_emitter_nvim_floatwin = v:true

nnoremap <silent> <Plug>(tataku-emitter-nvim_floatwin-focus) <Cmd>call tataku#emitter#nvim_floatwin#focus()<CR>
