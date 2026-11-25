# vim-edk2-snippet

A Vim menu for inserting EDK II code snippets.

## Installation

With [vim-plug](https://github.com/junegunn/vim-plug), add this between `plug#begin()` and `plug#end()` in your vimrc, then run `:PlugInstall`:

```vim
Plug 'misterb0407/vim-edk2-snippet'
```

## Usage

In any buffer, press `<Leader>e` in Normal mode, then enter the number of a snippet. Select `0` or press Escape to cancel. The snippet is inserted on the next line, aligned with the cursor's column. The menu contains 15 UEFI Boot Services protocol examples, each with a specification reference and brief description. Examples may need adaptation to the surrounding code; include the required protocol and library headers and INF dependencies.

Set the mapping before the plugin loads to change it:

```vim
let g:edk2_snippet_mapping = '<Leader>es'
```

To disable the default mapping, set `let g:edk2_snippet_no_default_mapping = 1`. To provide your own mapping, map to `<Plug>(edk2-snippet-menu)`; for example:

```vim
nmap <Leader>es <Plug>(edk2-snippet-menu)
```

The plugin does not replace an existing mapping for the configured key.
