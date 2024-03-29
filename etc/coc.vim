vim9script noclear
### config for coc.nvim{{{
if !empty(glob(g:vim_config_prefix .. '/_machine_different.vim/forcoc.vim'))
    exec 'source ' .. g:vim_config_prefix .. '/_machine_different.vim/forcoc.vim'
endif

# Use tab for trigger completion with characters ahead and navigate.
# NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
# other plugin before putting this into your config.
def CheckBackSpace(): bool
  var col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
enddef
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ <SID>CheckBackSpace() ? "\<C-h>" :
      \ "\<TAB>"

# Make <CR> to accept selected completion item or notify coc.nvim to format
# <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

# Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

# GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

# Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

def ShowDocumentation()
    if index(['vim', 'help'], &filetype) >= 0
        execute 'h ' .. expand('<cword>')
    elseif g:CocAction('hasProvider', 'hover')
        g:CocActionAsync('doHover')
    else
        feedkeys('K', 'in')
    endif
enddef

# Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

# Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

# Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  # Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  # Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

# Applying codeAction to the selected region.
# Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

# Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
# Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

# Introduce function text object
# NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

# Remap <C-f> and <C-b> for scroll float windows/popups.
# Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

# NeoVim-only mapping for visual mode scroll
# Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

# Use CTRL-S for selections ranges.
# Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

# Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap \\f :Format<CR>

# Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

# Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

# Mappings using CoCList:
# Show all diagnostics.
nnoremap <silent> <space>la  :<C-u>CocList diagnostics<CR>
# Manage extensions.
nnoremap <silent> <space>le  :<C-u>CocList extensions<CR>
# Show commands.
nnoremap <silent> <space>lc  :<C-u>CocList commands<CR>
# Find symbol of current document.
nnoremap <silent> <space>lo  :<C-u>CocList outline<CR>
# Search workspace symbols.
nnoremap <silent> <space>ls  :<C-u>CocList -I symbols<CR>
# Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
# Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
# Resume latest coc list.
nnoremap <silent> <space>lp  :<C-u>CocListResume<CR>
# List float terms
nnoremap <silent> <space>lt :CocList floaterm<CR>
# Mappings using coc-explorer
nmap <F2> :CocCommand explorer <CR>

# For coc-snippets
# Use <C-e> for trigger snippet expand.
imap <C-e> <Plug>(coc-snippets-expand)

# Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

# Use <C-j> for jump to next placeholder, it's default of coc.nvim
g:coc_snippet_next = '<c-j>'

# Use <C-k> for jump to previous placeholder, it's default of coc.nvim
g:coc_snippet_prev = '<c-k>'

# Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

# Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
### end of config for coc.nvim}}}
