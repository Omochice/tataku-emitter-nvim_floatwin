# tataku-emitter-nvim_floatwin 

The emitter module that use nvim floatwin for tataku.vim.

## Contents 

- [Dependencies](tataku-emitter-nvim_floatwin-dependencies)
- [Options](tataku-emitter-nvim_floatwin-options)
- [Mappings](tataku-emitter-nvim_floatwin-mappings)
- [Samples](tataku-emitter-nvim_floatwin-samples)

## Dependencies 

This plugin needs below:

- [denops.vim](https://github.com/vim-denops/denops.vim)
- [tataku.vim](https://github.com/Omochice/tataku.vim)

## Options 

This module has some options:

- `autoclose` 

  Close automatically when move cursor.
  Default: `v:true`
- `border` 

  Border setting for float window.
  This should be `string`(ref: [nvim_open_win](nvim_open_win))
  or `dictionary` that have below keys:

```typescript
[
	"topleft", "top", "topright", "right",
	"bottomright", "bottom", "bottomleft", "left",
]
```

## Mappings 

This module provides below mappings:

- `<Plug>(tataku-emitter-nvim_floatwin-focus)`

  Move the cursor into the float window if it is shown.
  The float window is not closed by `autoclose` while the cursor is in it.

## Samples 

```vim
let g:tataku_recipes = #{
  \   sample: #{
  \     emitter: #{
  \       name: 'nvim_floatwin',
  \       options: #{ border: 'single', autoclose: v:true, },
  \     },
  \   },
  \ }

nmap <C-w>p <Plug>(tataku-emitter-nvim_floatwin-focus)
```

