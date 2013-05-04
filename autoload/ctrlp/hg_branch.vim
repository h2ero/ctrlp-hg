if exists('g:loaded_ctrlp_hg_branch') && g:loaded_ctrlp_hg_branch
  finish
endif
let g:loaded_ctrlp_hg_branch = 1

let s:system = function(get(g:, 'ctrlp#hg#system_function', 'system'))

let s:hg_branch_var = {
\  'init':   'ctrlp#hg_branch#init()',
\  'accept': 'ctrlp#hg_branch#accept',
\  'lname':  'hg_branch',
\  'sname':  'hg_branch',
\  'type':   'path',
\  'nolim':  1,
\  'opmul':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:hg_branch_var)
else
  let g:ctrlp_ext_vars = [s:hg_branch_var]
endif

function! ctrlp#hg_branch#init()
  return map(split(s:system("hg branches | awk '{print $1}'"), "\n"), 'v:val')
endfunc

function! ctrlp#hg_branch#accept(mode, str)
  call ctrlp#exit()
  echo s:system('hg checkout '.shellescape(a:str))
endfunc

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#hg_branch#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
