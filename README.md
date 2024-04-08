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

<img src=sample/equationpreview1.gif width="50%">
<img src=sample/equationpreview2.gif width="50%">

```vim
[range]EqPreviewRange
```
Display the equation in [range] lines in another window.

<img src=sample/equationpreviewrange.gif width="50%">

## Requirements
* `job` supported Vim or neovim.
* [Python3](https://www.python.org/) and [matplotlib](https://matplotlib.org/)  
    NOTE: Python support of Vim/neovim is not required.
    Python is called as a job.

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```vim
Plug 'MeF0504/EquationPreview.vim'
```

## Options
* `g:equationpreview_color`  
    Specify the text color.
* `g:equationpreview_fontsize`  
    Specify the text font size.
* `g:equationpreview_width`  
    Specify the width of text-showing window.
    The unit is pixel.

## License
[MIT](https://github.com/MeF0504/EquationPreview.vim/blob/main/LICENSE)

## Author
[MeF0504](https://github.com/MeF0504)
