" equationpreview
" Author: MeF0504
" License: MIT

if exists('g:loaded_equationpreview')
  finish
endif
let g:loaded_equationpreview = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? EqPreview call equationpreview#main(<f-args>)
command! -range EqPreviewRange <line1>,<line2>call equationpreview#main()
command! -nargs=? EqPreviewLog call equationpreview#log(<args>)

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
