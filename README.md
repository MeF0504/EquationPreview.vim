# EquationPreview.vim

Vim plugin to preview the equation of $\LaTeX$ format.

## Usage

```vim
EqPreview [equation]
```
Display the equation in another window.
If no the equation are set,
1. If cursor is surrounded by `$$`, display the equation inside `$$`.
2. Otherwise display the current line in LaTeX format.

```vim
[range]EqPreviewRange
```
Display the equation in [range] lines in another window.

## Requirements
* `python3` supported Vim.
```vim
has('python3') " == 1
```
* any latex command to make PDF file from TeX file.

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```vim
Plug 'MeF0504/EquationPreview.vim'
```

## Options
* `g:equationpreview_headers`  
    Header lines of TeX file.  
    default: `[
              '\documentclass[a5paper,landscape,uplatex]{article}',
              '\pagestyle{empty}',
              '\usepackage{bxpapersize}',
              '\usepackage{amsmath}',
              '\usepackage{bm}',
             ]`
* `g:equationpreview_command`  
    A command to be used for compile tex file.
    default: `ptex2pdf`
* `g:equationpreview_opts`  
    Options for g:equationpreview_command.  
    default: `['-l']`
* `g:equationpreview_fontsize`  
    Specify the text font size.
    default: 20

## License
[MIT](https://github.com/MeF0504/EquationPreview.vim/blob/main/LICENSE)

## Author
[MeF0504](https://github.com/MeF0504)
