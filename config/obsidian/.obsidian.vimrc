" see https://github.com/esm7/obsidian-vimrc-support
" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

exmap togglefold obcommand editor:toggle-fold
nmap za :togglefold<CR>

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall<CR>

exmap foldall obcommand editor:fold-all
nmap zM :foldall<CR>
