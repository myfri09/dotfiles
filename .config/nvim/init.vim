" -- Automatic installation -------------------------------------------------------------------

" Place the following code in your .nvimrc before plug#begin() call

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

" -- display -------------------------------------------------------------------

if exists("+colorcolumn")
  set colorcolumn=81          " display a marker after column 80
endif

" --              --------------------------------------------------------------

" E576: Failed to parse ShaDa file: extra bytes in msgpack string at position 3
" https://vi.stackexchange.com/questions/10028/e576-failed-to-parse-shada-file-extra-bytes-in-msgpack-string-at-position-3
" Keep the existing file name when running vim, and use another when using neovim
    if !has('nvim')
      set viminfo+=n~/.vim/.viminfo
    else
      " Do nothing here to use the neovim default
      " or do soemething like:
      " set viminfo+=n~/.shada
    endif

" -- command mode --------------------------------------------------------------

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

"  -- Start of vim-plug manager ------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

  nnoremap <F5> :NERDTreeToggle<CR>

" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Code to execute when the plugin is lazily loaded on demand
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" UltiSnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<C-j>"
" let g:UltiSnipsJumpForwardTrigger="<C-j>"
" let g:UltiSnipsJumpBackwardTrigger="<C-k>"
"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Post-update hooks
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

" This is a vim syntax plugin for Ansible 2.0, it supports YAML playbooks, Jinja2 templates, and Ansible's hosts files.
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.py' }

" set the filetype to ansible, ansible_template, or ansible_hosts if auto-detection does not work
:set ft=ansible

  let g:ansible_unindent_after_newline = 1
  let g:ansible_attribute_highlight = "ob"
  let g:ansible_name_highlight = 'd'
  let g:ansible_extra_keywords_highlight = 1
  let g:ansible_normal_keywords_highlight = 'Constant'
  let g:ansible_with_keywords_highlight = 'Constant'

" Ansible snippets
" Plug 'phenomenes/ansible-snippets'

" Adds additional support for Ansible
" Plug 'chase/vim-ansible-yaml'
" let g:ansible_options = {'ignore_blank_lines': 0}

Plug 'hashivim/vim-terraform'

Plug 'markcornick/vim-vagrant'

Plug 'hashivim/vim-packer'

Plug 'ntpeters/vim-better-whitespace'

" Comment functions so powerful—no comment necessary.
" Plug 'scrooloose/nerdcommenter'

" Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1

Plug 'ervandew/supertab'

" insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

  let g:AutoPairsFlyMode = 0
  let g:AutoPairsShortcutBackInsert = '<M-b>'

" Syntax checking hacks
Plug 'scrooloose/syntastic'

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'

  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'

  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

  let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

  silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" This package provides kubernetes YAML snippets, as well as a growing number of integrations with kubectl
Plug 'andrewstuart/vim-kubernetes'

" Git wrapper so awesome
Plug 'tpope/vim-fugitive'

" Plugin acts as a completion helper for Cloud Formation Templates, and provides some basic syntax highlighting to help those tasked with reading templates.
"Plug 'm-kat/aws-vim'

  "let g:UltiSnipsSnippetDirectories=["UltiSnips", "./bundle/aws-vim/snips"]

" Operating Kubernetes Cluster from Vim, in Vim
Plug 'c9s/vikube.vim'

" Markdown Vim Mode
Plug 'plasticboy/vim-markdown'

  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_no_default_key_mappings = 1
  let g:vim_markdown_toc_autofit = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_json_frontmatter = 1
  let g:vim_markdown_no_extensions_in_markdown = 1
  let g:vim_markdown_autowrite = 1

" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

" javascript libraries syntax
"  let g:used_javascript_libs = 'jquery,underscore,react,flux,chai'

" Initialize plugin system
call plug#end()
" -- End vim-plug manage -------------------------------------------------------

" -- Plugin Settings -----------------------------------------------------------

" -- UltiSnips -----------------------------------------------------------

" make YCM compatible with UltiSnips (using supertab) by sudo bangbang
" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme/22253548#22253548
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger  . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
