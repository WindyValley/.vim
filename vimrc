"一些外观上的修改set formatoptions-=tc
set number
set relativenumber
set ruler
set cursorline
set cmdheight=2
syntax enable
syntax on

"编辑行为
set tabstop=4
set expandtab	"用等宽空格替代Tab
set shiftwidth=4
set softtabstop=4
set list
set listchars=tab:▸\ ,trail:▫
setlocal scrolloff=5

"系统级设置
set nocompatible "关闭对vi的兼容
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8

"set clipboard=unnamed "启用系统剪贴板，vim有内置方案可以沟通系统剪贴板，如无必要，可以不启用
set paste	"启用粘贴，否则vim会将粘贴视作短时间内的大量输入
set backspace=indent,eol,start

"不创建备份文件
set nobackup
set nowritebackup

" Status/command bar
set laststatus=2
set autochdir
set showcmd

"Search settings
set hlsearch
set incsearch

call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch':'release'}
call plug#end()


" 针对文件格式的设置
" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
  " autocmd FileType c,cpp  set omnifunc=ccomplete#Complete
augroup END
" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.  These aren't absolute rules; they're just an approximation of
" common style in LLVM source.
set cinoptions=:0,g0,(0,Ws,l1
" Add and delete spaces in increments of `shiftwidth' for tabs
set smarttab

" Highlight syntax in programming languages
syntax on

" LLVM Makefiles can have names such as Makefile.rules or TEST.nightly.Makefile,
" so it's important to categorize them as such.
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab


"自定义按键绑定
" VISUAL模式下绑定Ctrl+C为复制到系统剪贴板
vnoremap <C-c> "+y




