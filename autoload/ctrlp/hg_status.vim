if exists('g:loaded_ctrlp_hg_status') && g:loaded_ctrlp_hg_status
  finish
endif
let g:loaded_ctrlp_hg_status = 1

let s:system = function(get(g:, 'ctrlp#hg#system_function', 'system'))

let s:hg_status_var = {
\  'init':   'ctrlp#hg_status#init()',
\  'accept': 'ctrlp#hg_status#accept',
\  'lname':  'hg_status',
\  'sname':  'hg_status',
\  'type':   'path',
\  'nolim':  1,
\  'opmul':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:hg_status_var)
else
  let g:ctrlp_ext_vars = [s:hg_status_var]
endif

function! ctrlp#hg_status#init()
  return map(split(s:system("hg status | grep -P '^\\?|A|M '"), "\n"), 'v:val')
endfunc

function! ctrlp#hg_status#accept(mode, str)
  call ctrlp#exit()
  exe "e " . map(split(s:system("hg root"), "\n"), "v:val")[0] . "/" . join(split(a:str)[1:])
endfunc

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#hg_status#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2

