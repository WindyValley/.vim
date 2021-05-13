" key map without any function from plugins
" Keymap {{{

let mapleader=","
" convenient motion when line wrap on
noremap j gj
noremap k gk
" tab operations
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tc :tabnew<space>
nnoremap <leader>td :tabclose<CR>

" buffer operations
nnoremap <C-Left> :bp<CR>
nnoremap <C-Right> :bn<CR>

nmap <F1> :h<space>
noremap <M-c> :nohlsearch<CR>
nnoremap <M-]> zR
nnoremap <M-[> zM

" reload configs
nmap <leader>r :source $MYVIMRC<cr>
nmap <leader>e :e $MYVIMRC<cr>
nmap S :w<cr>
nmap Q :q<cr>

" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>

" IDE like delete
inoremap <C-BS> <Esc>bdei

nnoremap vv ^vg_
" 转换当前行为大写
inoremap <C-u> <esc>mzgUiw`za
" 命令模式下的行首尾
cnoremap <C-a> <home>
cnoremap <C-e> <end>

nnoremap <leader>w :set wrap!<cr>

" 打开当前目录 windows
map <leader>ex :!start explorer %:p:h<CR>

" 打开当前目录CMD
map <leader>cmd :!start<cr>
" 打印当前时间
map <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>

" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" }}}
