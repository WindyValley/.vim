vim9script noclear
g:vim_config_prefix = fnamemodify(expand('$MYVIMRC'), ':p:h')
execute 'so ' .. g:vim_config_prefix .. '/etc/universal.vim'
execute 'so ' .. g:vim_config_prefix .. '/etc/keybindings.vim'
g:plug_url_format = 'git@github.com:%s'
plug#begin(g:vim_config_prefix .. '/plugged')
    if !empty(glob(g:vim_config_prefix .. '/_machine_different.vim/pluglist.vim'))
        execute 'so ' .. g:vim_config_prefix .. '/_machine_different.vim/pluglist.vim'
    endif
    Plug 'yianwillis/vimcdoc'

    ### make me edit easy
    Plug 'neoclide/coc.nvim', {'branch':'release'}
    Plug 'fatih/vim-go', {'for': ['go', 'vim-plug'], 'tag': '*'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'tyru/caw.vim'
    Plug 'tpope/vim-surround'
    Plug 'lervag/vimtex', {'for': ['tex']}
    Plug 'honza/vim-snippets'
    Plug 'gcmt/wildfire.vim'
    Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo']  }
    Plug 'junegunn/vim-easy-align'

    ### Functional integrations
    Plug 'mbbill/undotree'
    Plug 'liuchengxu/vista.vim'
    Plug 'voldikss/vim-floaterm'
    Plug 'ryanoasis/vim-devicons'
    Plug 'liuchengxu/vim-which-key'
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
    # Plug 'glepnir/dashboard-nvim'
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'skywind3000/asyncrun.extra'
    Plug 'skywind3000/vim-quickui'
    if executable('tmux')
        Plug 'preservim/vimux'
    endif
    Plug 'voldikss/vim-translator'
    Plug 'tommcdo/vim-exchange'
    Plug 't9md/vim-choosewin'

    ### make it colorful
    Plug 'vim-airline/vim-airline'
    Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c', 'cpp']}

plug#end()

if !empty(glob(g:vim_config_prefix .. '/_machine_different.vim/dependonplug.vim'))
    execute 'so ' .. g:vim_config_prefix .. '/_machine_different.vim/dependonplug.vim'
endif
execute 'so ' .. g:vim_config_prefix .. '/etc/coc.vim'

### {{{ config for Vista.vim
noremap <c-t> :silent! Vista finder coc<CR>
noremap <c-l> :Vista!!<CR>
g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
g:vista_default_executive = 'coc'
g:vista_fzf_preview = ['right:50%']
g:vista#renderer#enable_icon = 1
g:vista#renderer#icons = {
 \   "function": "\uf794",
 \   "variable": "\uf71b",
 \  }
### end of config for Vista.vim}}}

###{{{ config with Floaterm
g:floaterm_keymap_new    = '<space>fc'
g:floaterm_keymap_prev   = '<space>fp'
g:floaterm_keymap_next   = '<space>fn'
g:floaterm_keymap_toggle = '<space>ft'
g:floaterm_position      = 'center'
###end of config with Floaterm}}}

###{{{ config for lines(bufferline & airline)
if !exists('g:airline_symbols')
   g:airline_symbols = {}
endif

g:airline_section_b = airline#section#create(['%{get(b:,''coc_git_status'','''')}', '%{get(g:,''coc_git_status'','''')}'])

g:airline#extensions#coc#enabled = 1
g:airline#extensions#coc#error_symbol = '✘'
g:airline#extensions#coc#warning_symbol = '⚡'
g:airline#extensions#coc#open_lnum_symbol = '[:'
g:airline#extensions#coc#close_lnum_symbol = '] '

g:airline#extensions#tabline#enabled = 1
g:airline#extensions#tabline#right_alt_sep = ''
g:airline#extensions#tabline#right_sep = ''
g:airline#extensions#tabline#left_alt_sep = ''
g:airline#extensions#tabline#left_sep = ''

g:airline_left_sep = ''
g:airline_left_alt_sep = ''
g:airline_right_sep = ''
g:airline_right_alt_sep = ''
g:airline_symbols.branch = ''
g:airline_symbols.readonly = ''
g:airline_symbols.linenr = '¶'
g:airline_symbols.maxlinenr = ''
g:airline_symbols.dirty = '⚡'
###}}}

###{{{config for translators
g:TerslationFloatWin = 1

# Echo translation in the cmdline
nmap <silent> <space>ts <Plug>Translate
vmap <silent> <space>ts <Plug>TranslateV

# Display translation in a window
nmap <silent> <space>tw <Plug>TranslateW
vmap <silent> <space>tw <Plug>TranslateWV

# Replace the text with translation
nmap <silent> <space>tr <Plug>TranslateR
vmap <silent> <space>tr <Plug>TranslateRV

# Translate the text in clipboard
nmap <silent> <space>tx <Plug>TranslateX
###end of config for translators}}}

###{{{ config for whick-key
nnoremap <silent> <space>  :<c-u>WhichKey '<space>'<CR>
nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
nnoremap <silent> \        :<c-u>WhichKey '\'<CR>
###end of config for which-key}}}

###{{{ config for vimtex
g:tex_flavor = "latex"
# use vimtex as default compiler
g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}
g:vimtex_compiler_latexrun_engines = {'_': 'xelatex'}

if has('win32') || has('win64')
# 阅读器相关的配置 包含正反向查找功能 仅供参考
    g:vimtex_view_general_viewer = 'H:/SumatraPDF/SumatraPDF.exe'
    g:vimtex_view_general_options_latexmk = '-reuse-instance'
    g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
                                    .. ' -inverse-search "' .. exepath(v:progpath)
                                    .. ' --servername ' .. v:servername
                                    .. ' --remote-send \"^<C-\^>^<C-n^>'
                                    .. ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
                                    .. ':\%l^<CR^>:normal\! zzzv^<CR^>'
                                    .. ':call remote_foreground(''' .. v:servername .. ''')^<CR^>^<CR^>\""'
else
# use zathura as the default pdf reviewer
    g:vimtex_view_method = 'zathura'
endif

# show the compiler hint
g:vimtex_quickfix_mode = 1

# hide the last two lines
set conceallevel=1

g:tex_conceal = 'abdmg'
###}}}

###{{{ config for vim-go
g:go_echo_go_info = 0
g:go_doc_popup_window = 1
g:go_def_mapping_enabled = 0
g:go_template_autocreate = 0
g:go_textobj_enabled = 0
g:go_auto_type_info = 1
g:go_def_mapping_enabled = 0
g:go_highlight_array_whitespace_error = 1
g:go_highlight_build_constraints = 1
g:go_highlight_chan_whitespace_error = 1
g:go_highlight_extra_types = 1
g:go_highlight_fields = 1
g:go_highlight_format_strings = 1
g:go_highlight_function_calls = 1
g:go_highlight_function_parameters = 1
g:go_highlight_functions = 1
g:go_highlight_generate_tags = 1
g:go_highlight_methods = 1
g:go_highlight_operators = 1
g:go_highlight_space_tab_error = 1
g:go_highlight_string_spellcheck = 1
g:go_highlight_structs = 1
g:go_highlight_trailing_whitespace_error = 1
g:go_highlight_types = 1
g:go_highlight_variable_assignments = 0
g:go_highlight_variable_declarations = 0
g:go_doc_keywordprg_enabled = 0
###end}}}

###{{{ config for wildfire.vim
# use '*' to mean 'all other filetypes'
# in this example, html and xml share the same text objects
g:wildfire_objects = {
        "*": ["i'", "i\"", "i<", "i)", "i]", "i}", "ip", "if", "af"],
        "html,xml,php": ["at", "it"],
    }
###}}}

###{{{ config for UndoTree
g:undotree_WindowLayout = 'Layout 2'
nnoremap <C-u> :UndotreeShow<CR>:UndotreeFocus<CR>
###}}}

### {{{ config for far
nnoremap <LEADER>fr :Farr<CR>
g:far#enable_undo = 1
### }}}

### {{{ config for Asyncrun/AsynxTasks
au! BufRead,BufNewFile .tasks set ft=dosini
g:asyncrun_mode = 'floaterm'
g:asyncrun_rootmarkers = ['.git', '.svn', '.project', 'build', 'go.mod', 'Cargo.toml']
g:asynctasks_term_pos = 'floaterm'
g:asynctasks_extra_config = [
    g:vim_config_prefix .. '/tasks.ini',
]

nnoremap <silent><F7> :AsyncTask project-build<CR>
nnoremap <silent><C-F7> :AsyncTask file-build<CR>
nnoremap <silent><F6> :AsyncTask project-run<CR>
nnoremap <silent><C-F6> :AsyncTask file-run<CR>
### }}}

### {{{ config for dashboard-nvim
# nmap <space>ss :<C-u>SessionSave<CR>
# nmap <space>sl :<C-u>SessionLoad<CR>
# nnoremap <silent> <space>lh :DashboardFindHistory<CR>
# nnoremap <silent> <space>lf :DashboardFindFile<CR>
# nnoremap <silent> <space>cc :DashboardChangeColorscheme<CR>
# nnoremap <silent> <space>lw :DashboardFindWord<CR>
# nnoremap <silent> <space>lm :DashboardJumpMark<CR>
# nnoremap <silent> <space>nf :DashboardNewFile<CR>
# g:dashboard_custom_shortcut = {
#       'last_session':       'SPC s l',
#       'find_history':       'SPC l h',
#       'find_file':          'SPC l f',
#       'new_file':           'SPC n f',
#       'change_colorscheme': 'SPC c c',
#       'find_word':          'SPC l w',
#       'book_marks':         'SPC l m',
# }
### }}}

### {{{ config for vim-clap
nnoremap <silent> <space>lb :Clap buffers<CR>
nnoremap <silent> <space>ly :Clap yanks<CR>
### }}}

### {{{ config for vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
### }}}

### {{{ config for vim-choosewin
nmap - <Plug>(choosewin)
### }}}
