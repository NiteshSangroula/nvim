let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
   let g:ulti_expand_or_jump_res = 0 "default value, just set once
   function! Ulti_ExpandOrJump_and_getRes()
     call UltiSnips#ExpandSnippetOrJump()
     return g:ulti_expand_or_jump_res
   endfunction
inoremap <C-s> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":IMAP_Jumpfunc('', 0)<CR>
