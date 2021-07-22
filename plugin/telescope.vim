nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>lo :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vrc :lua require('theprimeagen.telescope').search_dotfiles()<CR>
nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
nnoremap <leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
nnoremap <leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

nnoremap // <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap ?? <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>ob <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>oh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>om <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>oc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>of <cmd>lua require('telescope.builtin').find_files()<cr>
