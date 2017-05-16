" vim script start 
" =============        Signature      ===================
" @version : -1.1
" @last-update : 2017-01-26 
" @file : vimrc
" @git : https://github.com/drake-jin/.dotfiles/
" @desc : setting vim 
" @sub-desc : this config is based on https://github.com/fisadev/fisa-vim-config
" ============================================================


" ==============         Plug in installation      =========================
let is_installed_vim_plug = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')

if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    "Junegunn,the best of open source creator, is who has worked at kakao co.
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let is_installed_vim_plug = 1
endif

" manually load vim-plug the first time
if is_installed_vim_plug
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ===========================================================================
call plug#begin('~/.vim/plugged')



" ==================  Plugins from github repos  ======================
"---------------------------
"    file system viewer
"---------------------------
Plug 'arielrossanigo/dir-configs-override.vim' " Override configs by directory 

"-------------------------
"   IDE Features
"--------------------------
Plug 'scrooloose/nerdtree'              " Better file browser
Plug 'majutsushi/tagbar'                " Class module browser
Plug 'mileszs/ack.vim'                  " Ack code search (requires ack installed in the system)
Plug 'scrooloose/syntastic'             " Python and other languages code checker
Plug 'ctrlpvim/ctrlp.vim'               " Code and files fuzzy finder
Plug 'kien/tabman.vim'                  " Tab list panel
Plug 'vim-airline/vim-airline'          " Airline ,Showing vi editor's status INSERT >> +0 ~0 -0 | vimrc[+]                              vim | utf-8[unix]  ....
Plug 'vim-airline/vim-airline-themes'   " Airline's theme

Plug 'fisadev/FixedTaskList.vim'        " Pending tasks list   
"USAGE : if you write 'todo' in file, task manage will anchor the text and go the line [press <F2> on this setting]


"--------------------
" Color Schemes
"--------------------
Plug 'fisadev/fisa-vim-colorscheme'     " Terminal Vim with 256 colors colorscheme



"-------------------------
"   Fast Editing
"--------------------------
Plug 'tpope/vim-surround'               " Surround
Plug 'scrooloose/nerdcommenter'         " Code commenter
Plug 'michaeljsmith/vim-indent-object'  " Indent text object
Plug 'jeetsukumaran/vim-indentwise'     " Indentation based movements
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   " Quick Search
Plug 'junegunn/fzf.vim'                                             " Quick Search




"------------------------
"   Code Completions
"-----------------------
Plug 'mattn/emmet-vim'                  " Zen coding
Plug 'Shougo/neocomplcache.vim'         " Better autocompletion
Plug 'Townk/vim-autoclose'              " Autoclose  like { then, }  ( then, )


"---------------------------------------------
"   Syntax/Indent for any language enhancement
"--------------------------------------------

" ----------------python---------------------
Plug 'klen/python-mode'                 " Python mode (indentation, doc, refactor, lints, code checking, motion and operators, highlighting, run and ipdb breakpoints)
Plug 'fisadev/vim-isort'                " Automatically sort python imports
if has('python')
    " YAPF formatter for Python
    Plug 'pignacio/vim-yapf-format'
endif

"------------others----------------


"---------------------
"   Snippets 
"---------------------
Plug 'MarcWeber/vim-addon-mw-utils'     " dependencies
Plug 'tomtom/tlib_vim'                  " dependencies
" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'


"---------------------------
"  vim-scripts for plugins
"---------------------------
Plug 'IndexedSearch'                    " Search results counter
Plug 'matchit.zip'                      " XML/HTML tags navigation
Plug 'Wombat'                           " Gvim colorscheme
Plug 'YankRing.vim'                     " Yank history navigation
Plug 'fisadev/vim-ctrlp-cmdpalette'     " Extension to ctrlp, for fuzzy command finder 
Plug 'fisadev/dragvisuals.vim'          " Drag visual blocks arround



"-----------------------
" Gist
"-----------------------
Plug 'mattn/gist-vim'
"Plug 'mattn/webapi-vim'


"----------------------
" other utils
"---------------------
Plug 'motemen/git-vim'                  " Git integration
Plug 'mhinz/vim-signify'                " Git/mercurial/others diff icons on the side of the file lines
Plug 't9md/vim-choosewin'               " Window chooser
Plug 'lilydjwg/colorizer'               " Paint css colors with the real color
Plug 'rosenfeld/conque-term'            " Consoles as buffers, To use any command in vi editor. execute :ConqueTermSplit top


" ------- javascript eslint ----
Plug 'mtscout6/syntastic-local-eslint.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()


" ============================================================================
" Install plugins the first time vim runs

if is_installed_vim_plug
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================



" Vim settings and mappings
" You can edit them as you wish
" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" no vi-compatible
set nocompatible
" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" always show status bar
set ls=2
" incremental search
set incsearch
" highlighted search results
set hlsearch
" show line numbers
set nu
" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3
" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest
" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo


" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

syntax on


" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
" eslint based airbnb ..
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Right> <ESC>:tabn<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

" save as sudo
ca w!! w !sudo tee "%"

" simple recursive grep
nmap ,r :Ack 
nmap ,wr :Ack <cword><CR>


" vim gist 
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'w3m %URL%'
let g:gist_post_private = 1
let g:gist_post_anonymous = 1
let g:gist_get_multiplefile = 1

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    colorscheme fisa
else
    colorscheme delek
endif

" colors for gvim
if has('gui_running')
    colorscheme wombat
endif
" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar ----------------------------- 

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree ----------------------------- 

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" CtrlP ------------------------------

" file finder mapping
let g:ctrlp_map = ',e'
" tags (symbols) in current file finder mapping
nmap ,g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap ,f :CtrlPLine<CR>
" recent files finder mapping
nmap ,m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap ,c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" Syntastic ------------------------------

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0




" custom icons (enable them if you use a patched font, and enable the previous setting)
" if you can't see  this character '⮀'  have to close this comment line  
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_style_warning_symbol = '💩'




" Python-mode ------------------------------

" 2017-02-25 yjcho modified
" pep8 setting /keln/python-mode.git

" don't use linter, we use syntastic for that
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" open definitions on same window, and custom mappings for definitions and occurrences

" Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"
" Override view python doc key shortcut to [Ctrl-Shift-d]
let g:pymode_doc_bind = "<C-S-d>"
let g:pymode_python= 'python3'

let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'
nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
nmap ,o :RopeFindOccurrences<CR>


" NeoComplCache ------------------------------

" most of them not documented because I'm not sure how they work
" (docs aren't good, had to do a lot of trial and error to make 
" it play nice)
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_min_syntax_length = 1
" complete with workds from any opened file
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_same_filetype_lists._ = '_'

" TabMan ------------------------------

" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" DragVisuals ------------------------------

" mappings to move blocks in 4 directions
vmap <expr> <S-M-LEFT> DVB_Drag('left')
vmap <expr> <S-M-RIGHT> DVB_Drag('right')
vmap <expr> <S-M-DOWN> DVB_Drag('down')
vmap <expr> <S-M-UP> DVB_Drag('up')
" mapping to duplicate block
vmap <expr> D DVB_Duplicate()

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif

" if you can't see  this character '⮀'  have to close this comment line  
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'



" eslint settings"
" 2017-01-30
" syntactic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


" Quick Search Junegunn's fzf Plugin.
" 2017-05-17
" Fast Editing




" Global Option
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


" Command-localOption
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'






" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,<bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
            \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with
"?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         :fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden','?'),
            \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)






" [Usage]

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})


" If installed using git
set rtp+=~/.fzf



















