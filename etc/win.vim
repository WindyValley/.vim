" Startup {{{
filetype indent plugin on

if empty(glob(expand('~').'\vimfiles\autoload\plug.vim'))
  silent exec '!curl -fLo ' . expand('~') . '\vimfiles\autoload\plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim 文件折叠方式为 marker
augroup ft_vim
    au!

    
augroup END
" }}}

" General {{{
set history=1024
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享, 推荐使用"+y因为vim里删除的内容也会写入剪切板
" set clipboard+=unnamed 
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" }}}
