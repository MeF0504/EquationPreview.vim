scriptencoding utf-8
let s:script_file = expand('<sfile>:h')..'/equationpreview/main.py'

function! s:set_param() abort
    let s:tmpfile = get(s:, 'tmpfile', tempname()..'.py')
    let s:color = get(g:, 'equationpreview_color', 'black')
    let s:fontsize = get(g:, 'equationpreview_fontsize', 14)
    let s:width = get(g:, 'equationpreview_width', 300)
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

function! s:get_script(eq_list) abort
    if filereadable(s:script_file)
        let script = join(readfile(s:script_file), "\n")
        let script = printf(script, a:eq_list,
                    \ s:width, s:color, s:fontsize)
        call writefile(split(script, "\n"), s:tmpfile)
        let ret = v:true
        " echomsg s:tmpfile
    else
        let ret = v:false
    endif
    return ret
endfunction

function! equationpreview#main(...) abort range
    call s:set_param()

    if a:0 == 0
        let eq_str = s:get_eq_str(a:firstline, a:lastline)
    else
        let eq_str = a:1
    endif
    let eq_list = '['..join(map(split(eq_str, '\\\\'), "printf('r\"%s\"', v:val)"), ', ')..']'
    let eq_list = substitute(eq_list, '&', '', 'g')
    let res = s:get_script(eq_list)
    if !res
        echohl Error
        echomsg 'failed to create a python script'
        echohl None
        return
    endif
    if has('nvim')
        let jid = jobstart(printf('python3 %s', s:tmpfile))
    else
        let jid = job_start(printf('python3 %s', s:tmpfile))
    endif
    " echomsg jid
endfunction

