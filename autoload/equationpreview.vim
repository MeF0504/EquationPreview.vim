scriptencoding utf-8
py3file <sfile>:h/equationpreview/main.py
python3 import vim

function! s:set_param() abort
    let s:packages = get(g:, 'equationpreview#headers', [
                \ '\documentclass[a5paper,landscape,uplatex]{article}',
                \ '\pagestyle{empty}',
                \ '\usepackage{bxpapersize}',
                \ '\usepackage{amsmath}',
                \ '\usepackage{bm}',
                \])
    let s:cmd = get(g:, 'equationpreview#command', 'ptex2pdf')
    let s:cmd_opt = get(g:, 'equationpreview#opts', ['-l'])
    let s:fs = get(g:, 'equationpreview#fontsize', 20)
endfunction

function! s:get_eq_str(first, last) abort
    if a:first == a:last
        let [bn, line, col, off] = getpos('.')
        let ln_str = getline('.')
        let match_st = 0
        while v:true
            let [eq_str, st, end] = matchstrpos(ln_str, '\$.\{-}\$', match_st)
            if empty(eq_str)
                return ln_str
            endif
            if st < col && col < end
                return eq_str[1:-2]
            else
                let match_st = end
            endif
        endwhile
    else
        return join(getline(a:first, a:last), " ")
    endif
endfunction

function! equationpreview#main(...) abort range
    call s:set_param()
    if !executable(s:cmd)
        echo printf('%s is not executable.', s:cmd)
        return
    endif

    if a:0 == 0
        let eq_str = s:get_eq_str(a:firstline, a:lastline)
    else
        let eq_str = a:1
    endif
    python3 eqpreview_main(vim.eval('eq_str'), vim.eval('s:cmd'), vim.eval('s:fs'),
                \ vim.eval('s:packages'), vim.eval('s:cmd_opt'))
endfunction

augroup EqPreview
    autocmd!
    autocmd VimLeavePre * python3 eqpreview_close()
augroup END

