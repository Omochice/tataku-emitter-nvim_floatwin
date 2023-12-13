# tataku-emitter-nvim_floatwin 

The emitter module that use nvim floatwin for tataku.vim.

## Contents 

- [Dependencies](tataku-emitter-nvim_floatwin-dependencies)
- [Options](tataku-emitter-nvim_floatwin-options)
- [Samples](tataku-emitter-nvim_floatwin-samples)

## Dependencies 

This plugin needs below:

- [denops.vim](https://github.com/vim-denops/denops.vim)
- [tataku.vim](https://github.com/Omochice/tataku.vim)

## Options 

This module has some options:

- `autoclose` 

  Close automaticaly when move cursor.
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
```

