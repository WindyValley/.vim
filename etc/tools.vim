vim9script noclear

# 依赖外部工具达成的功能

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif
