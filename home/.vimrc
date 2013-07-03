set nocompatible

"===============================================================================
" NeoBundle
"===============================================================================

if has ('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
      \   'windows': 'make -f make_mingw32.mak',
      \   'cygwin': 'make -f make_cygwin.mak',
      \   'mac': 'make -f make_mac.mak',
      \   'unix': 'make -f make_unix.mak',
      \ } }


" Fuzzy search
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
NeoBundle 'Shougo/unite-session'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'mileszs/ack.vim'

" Code completion
" NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'vim-scripts/AutoComplPop'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'SirVer/ultisnips'

" Comments
" NeoBundle 'scrooloose/nerdcommenter'

" File browsing
NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'Shougo/vimfiler'

"Buffers
" NeoBundle 'sandeepcr529/Buffet.vim'

" Text objects
" NeoBundle 'tpope/vim-surround'
" NeoBundle 'tpope/vim-repeat'

" Git
NeoBundle 'tpope/vim-fugitive'

" Motions
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'goldfeld/vim-seek'

" Syntax
NeoBundle 'scrooloose/syntastic'
NeoBundle 'nvie/vim-flake8'

" Shell
" NeoBundle 'thinca/vim-quickrun'
" NeoBundle 'Shougo/vimshell'
" NeoBundle 'tpope/vim-dispatch'

" Tags
NeoBundle 'majutsushi/tagbar'

" File types
" NeoBundle 'rstacruz/sparkup', {'rtp': 'vim'} "HTML
NeoBundle 'tpope/vim-markdown' "Markdown
NeoBundle 'terryma/vim-instant-markdown' "Markdown

" Status line
NeoBundle 'terryma/vim-powerline'
" Powerline is managed via python pip install
" NeoBundle 'Lokaltog/powerline'

" Search
NeoBundle 'kien/ctrlp.vim'

"Colors

NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'

" Misc
" NeoBundle 'sjl/gundo.vim'
" NeoBundle 'terryma/vim-smooth-scroll'



filetype plugin indent on
syntax enable

NeoBundleCheck

"-------------------------------------------------------------------
" General Settings
"-------------------------------------------------------------------

augroup MyAutoCmd
    autocmd!
augroup END

syntax on

" This took a while to figure out. Neocomplcache + iTerm + the CursorShape
" fix is causing the completion menu popup to flash the first result. Tested it
" with AutoComplPop and the behavior doesn't exist, so it's isolated to
" Neocomplcache... :( Dug into the source for both and saw that AutoComplPop is
" setting lazyredraw to be on during automatic popup...
" set lazyredraw

" Solid line for vsplit separator
set fcs=vert:│

" Turn on the mouse, since it doesn't play well with tmux anyway. This way I can
" scroll in the terminal
set mouse=a

" Give one virtual space at end of line
set virtualedit=onemore

" Turn on line number
set number

" Always splits to the right and below
set splitright
set splitbelow

" 256bit terminal
set t_Co=256

" Tell Vim to use dark background
set background=dark

" Colorscheme
colorscheme jellybeans

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Set to auto write file
set autowriteall

" listchar=trail is not as flexible, use the below to highlight trailing
" whitespace. Don't do it for unite windows or readonly files
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup MyAutoCmd
    autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
    autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
    autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
    autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
augroup END

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=10

" No need to show mode due to Powerline
set noshowmode

" Auto complete setting
set completeopt=longest,menuone
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set wildmode=list:longest,full
set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Allow changing buffer without saving it first
set hidden

" Set backspace config
set backspace=eol,start,indent

" Case insensitive search
set ignorecase
set smartcase

" Highlight search terms
set hlsearch
set incsearch

" Setting this causes problems with Unite-outline. Don't really need it
" set winminheight=5

" Make search act like search in modern browsers
set incsearch

" Make regex a little easier to type
set magic

" Don't show matching brackets
set noshowmatch

" Show incomplete commands
set showcmd

" Turn off sound
set vb
set t_vb=

" Always show the statusline
set laststatus=2

" Explicitly set encoding to utf-8
set encoding=utf-8

" Column width indicator
" set colorcolumn=+1
" set colorcolumn=80
" highlight ColorColumn guibg=#303030 ctermbg=0

" Lower the delay of escaping out of other modes
set timeout timeoutlen=1000 ttimeoutlen=0

" Reload vimrc when edited, also reload the powerline color
" autocmd MyAutoCmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
"       \ so $MYVIMRC | call Pl#Load() | if has('gui_running') | so $MYGVIMRC | endif

" Disable auto comment lines
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Text display settings
set linebreak
" set textwidth=80
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" Spelling highlights. Use underline in term to prevent cursorline highlights
" from interfering
if !has("gui_running")
  hi clear SpellBad
  hi SpellBad cterm=underline ctermfg=red
  hi clear SpellCap
  hi SpellCap cterm=underline ctermfg=blue
  hi clear SpellLocal
  hi SpellLocal cterm=underline ctermfg=blue
  hi clear SpellRare
  hi SpellRare cterm=underline ctermfg=blue
endif

" Use a low updatetime. This is used by CursorHold
set updatetime=1000

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"tab settings
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftwidth=4
set smarttab
set copyindent


"-------------------------------------------------------------------
" Function key mappings
"-------------------------------------------------------------------

" <F1>: Help
nmap <F1> [unite]h

" <F3>: Toggle GUndo
nnoremap <F3> :<C-u>GundoToggle<CR>

"-------------------------------------------------------------------
" Leader key mappings
"-------------------------------------------------------------------

let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","



" <Leader>1: Toggle between paste mode
nnoremap <silent> <Leader>1 :set paste!<cr>

" <leader>2: Toggle Tagbar
" nnoremap <silent> <Leader>2 :TagbarToggle<cr>

" <Leader>tab: Toggles NERDTree
nnoremap <Leader><tab> :NERDTreeToggle<cr>

" <Leader>q: Quit all, very useful in vimdiff
nnoremap <Leader>q :qa<cr>

" <Leader>w: Save all
nnoremap <Leader>w :wa<cr>

" set the search back to blank
nmap <silent> ,/ :nohlsearch<CR>

" <Leader>o: only
nnoremap <Leader>o :only<cr>

" <Leader>d: delete current buffer
nnoremap <Leader>d :bdelete<cr>

" quick load vimrc
nmap <silent> <leader>e :e $MYVIMRC<CR>

" <Leader>f: Open Quickfix
nnoremap <silent> <Leader>f :botright copen<CR>

"<Leader>c* NerdCommenter mappings

" <Leader>cd: change to the directory of the current buffer
nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

" <Leader>n: NERDTreeFind
nnoremap <silent> <Leader>n :NERDTreeFind<cr> :wincmd p<cr>

" <Leader>s: Spell checking shortcuts
nnoremap <Leader>ss :setlocal spell!<cr>
nnoremap <Leader>sj ]s
nnoremap <Leader>sk [s
nnoremap <Leader>sa zg]s
nnoremap <Leader>sd 1z=
nnoremap <Leader>sf z=

" <Leader>m: Maximize current split
nnoremap <Leader>m <C-w>_<C-w><Bar>

" <Leader>,: Switch to previous split
nnoremap <Leader>, <C-w>p

"-------------------------------------------------------------------
" Normal mode shift key mappings
"-------------------------------------------------------------------

" Shift-Tab: NERDTree
nnoremap <S-Tab> :NERDTreeToggle<CR>

" Q: Closes the window
nnoremap Q :q<cr>

" W: Move word forward (TODO Replaced by <C-L>, maybe remap?)

" E: Move to end of word forward

" R: Replace mode (When do I ever use this?)

" Y: Remove join lines to this, Y looks like a join of two lines into one
nnoremap Y J

" T: Finds till backwards

" U: Redos since 'u' undos
nnoremap U <c-r>

" I: Insert at beginning of line

" O: Insert line above

" P: Paste above line

" {: Beginning of paragraph

" }: End of paragraph

" _ : Quick horizontal splits
nnoremap _ :sp<cr>

" | : Quick vertical splits
nnoremap <bar> :vsp<cr>

" A: Insert at end of line

" S: Vim-seek backward

" D: Deletes til the end of line

" F: Finds backwards

" G: Go to end of file

" H: Go to beginning of line. Repeated invocation goes to previous line
noremap <expr> H getpos('.')[2] == 1 ? 'k' : '^'

" J: expand-region
map K <Plug>(expand_region_expand)

" K: shrink-region
map J <Plug>(expand_region_shrink)

" L: Go to end of line. Repeated invocation goes to next line
noremap <expr> L <SID>end_of_line()
function! s:end_of_line()
  let l = len(getline('.'))
  if (l == 0 || l == getpos('.')[2]-1)
    return 'jg_'
  else
    return 'g_'
endfunction

" ": Handles registers

" Z: TODO

" X: Deletes character backward (When was the last time I actually used this?)

" C: Deletes rest of line and go to insert mode

" V: Visual line mode

" B: Move word backward (TODO Replaced by <C-H>, maybe remap?)

" N: Find next occurrence backward
nnoremap N Nzzzv

" M: Move cursor to mid screen (When was the last time I actually used this?)

" <: Indent left

" >: Indent right

" ?: Search backwards

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

"-------------------------------------------------------------------
" Normal mode Ctrl key mappings
"-------------------------------------------------------------------

" Ctrl-q: Visual block mode

" Ctrl-w: Window management

" Ctrl-r: Command history using Unite, this matches my muscle memory in zsh
nmap <c-r> [unite];

" Ctrl-t: Go back in tag stack

" Ctrl-t*: Tab operations (When was the last time I used tabs?)
nnoremap <c-t><c-n> :tabnew<cr>
nnoremap <c-t><c-w> :tabclose<cr>
nnoremap <c-t><c-j> :tabprev<cr>
nnoremap <c-t><c-h> :tabprev<cr>
nnoremap <c-t><c-k> :tabnext<cr>
nnoremap <c-t><c-l> :tabnext<cr>
let g:lasttab = 1
nnoremap <c-t><c-t> :exe "tabn ".g:lasttab<cr>
autocmd MyAutoCmd TabLeave * let g:lasttab = tabpagenr()

" Ctrl-y: Yanks
nmap <c-y> [unite]y

" Ctrl-u: Scroll half a screen up smoothly
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 3)<CR>

" Ctrl-i: Go forward in the jumplist, also realigns screen. See mapping for
" <M-s>

" Ctrl-o: Go back in the jumplist, also realign the screen
" nnoremap <c-o> <c-o>zzzv

" Ctrl-p: Previous cursor in MultiCursor mode

" Ctrl-[: Esc

" Ctrl-]: Go forward in tag stack

" Ctrl-\: Quick outline
nmap <silent> <c-\> [unite]o

" Ctrl-a: TODO

" Ctrl-sa: (S)elect (a)ll
nnoremap <c-s><c-a> :keepjumps normal ggVG<CR>
" Ctrl-ss: (S)earch word under cur(s)or in current directory
nnoremap <c-s><c-s> :Unite grep:.::<C-r><C-w><CR>
" Ctrl-sd: (S)earch word in current (d)irectory (prompt for word)
nnoremap <c-s><c-d> :Unite grep:.<CR>
" Ctrl-sf: Quickly (s)earch in (f)ile
nmap <c-s><c-f> [unite]l
" Ctrl-sr: Easier (s)earch and (r)eplace
nnoremap <c-s><c-r> :%s/<c-r><c-w>//gc<left><left><left>
" Ctrl-sw: Quickly surround word
nmap <c-s><c-w> ysiw

" Ctrl-d: Scroll half a screen down smoothly
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 3)<CR>

" Ctrl-fm: (F)ind (M)RU and buffers
nmap <c-f><c-m> [unite]u

" Ctrl-fa: (F)ind (A)all files recursively
nmap <c-f><c-a> [unite]f

" Ctrl-fd: (F)ind (d)irectory. Change directory
nmap <c-f><c-d> [unite]d

" Ctrl-ff: EasyMotion
" Ctrl-ft: EasyMotion

" Ctrl-g: Prints current file name
nnoremap <c-g> 1<c-g>

" Ctrl-h: Move word back. Consistent with zsh
noremap <c-h> b

" Ctrl-j: Scroll + move down through the file
noremap <c-j> 3<c-e>3j

" Ctrl-k: Scroll + move up through the file
noremap <c-k> 3<c-y>3k

" Ctrl-l: Move word forward. Consistent with zsh
noremap <c-l> w

" Ctrl-;: Vim can't map this

" Ctrl-': Vim can't map this

" Ctrl-z: This is the command key for tmux

" Ctrl-x: Skip curosr in MultiCursor mode

" Ctrl-c: (C)ycle through the splits. I don't ever use enough splits to justify
" wasting 4 very easy to hit keys for them.
nnoremap <c-c> <c-w>w

" Ctrl-v: Paste (works with system clipboard due to clipboard setting earlier)
" nnoremap <c-v> p

" Ctrl-b: Go (b)ack. Go to previous buffer
nnoremap <c-b> <c-^>

" Ctrl-n: Next cursor in MultiCursor mode

" Ctrl-m: Same as Enter

" Ctrl-,: Vim can't map this

" Ctrl-.: Vim can't map this

" Ctrl-/: A more powerful '/'
nmap <c-_> [unite]l

" Ctrl-Space: Quick scratch buffer
nmap <C-@> <Plug>(scratch-open)
nmap <C-Space> <C-@>

"-------------------------------------------------------------------
" Insert mode contrl key mappings
"-------------------------------------------------------------------
 " Ctrl-q: Quoted insert. Useful for doing key binding

" Ctrl-w: Delete previous word, create undo point
inoremap <c-w> <c-g>u<c-w>

" Ctrl-e: Go to end of line
inoremap <c-e> <esc>A

" Ctrl-r: Insert register

" Ctrl-t: Indent shiftwidth

" Ctrl-y: Insert char above cursor

" Ctrl-u: Delete till beginning of line, create undo point
inoremap <c-u> <c-g>u<c-u>

" Ctrl-i: Tab

" Ctrl-o: Execute one normal mode command

" Ctrl-p: Auto complete previous

" Ctrl-a: Go to begin of line
inoremap <c-a> <esc>I

" Ctrl-s: Save
inoremap <c-s> <esc>:w<CR>

" Ctrl-d: Unindent shiftwidth

" Ctrl-f: Move cursor left
inoremap <c-f> <Left>

" Ctrl-h: Move word left
inoremap <c-h> <c-o>b

" Ctrl-j: Move cursor up
inoremap <expr> <c-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"

" Ctrl-k: Move cursor up
inoremap <expr> <c-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"

" Ctrl-l: Move word right
inoremap <c-l> <c-o>w

" Ctrl-z: This is the command key for tmux

" Ctrl-x: Delete char under cursor. (If we simply use x, it wouldn't delete
" newline chars
" inoremap <c-x> <right><c-o>X

" Ctrl-c: Inserts line below
inoremap <c-c> <c-o>o

" Ctrl-v: Paste. For some reason, <c-o> is not creating an undo point in the
" mapping
inoremap <c-v> <c-g>u<c-o>gP

" Ctrl-b: TODO

" Ctrl-n: Auto complete next

" Ctrl-m: Same as Enter

" Ctrl-space: TODO

" Ctrl-/: Undo
inoremap <c-_> <c-o>u


"-------------------------------------------------------------------
" Powerline
"-------------------------------------------------------------------
" Use the fancy version of Powerline symbols
" let g:Powerline_symbols = 'fancy'


"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup


"-------------------------------------------------------------------
" Unite
"-------------------------------------------------------------------

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ ], '\|'))

" Map space to the prefix for Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite
      \ -buffer-name=files buffer file_mru bookmark file_rec/async<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers buffer file_mru<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

" Quick snippet
nnoremap <silent> [unite]s :<C-u>Unite -buffer-name=snippets snippet<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d
      \ :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick find
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=find find:.<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" Fuzzy search from current buffer
" nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir
      " \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>

" Quick commands
nnoremap <silent> [unite]; :<C-u>Unite -buffer-name=history history/command command<CR>

" Custom Unite settings
autocmd MyAutoCmd FileType unite call s:unite_settings()
function! s:unite_settings()

  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
  " imap <buffer> <c-j> <Plug>(unite_select_next_line)
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  imap <buffer> <Tab> <Plug>(unite_exit_insert)
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')

  " Using Ctrl-\ to trigger outline, so close it using the same keystroke
  if unite.buffer_name =~# '^outline'
    imap <buffer> <C-\> <Plug>(unite_exit)
  endif

  " Using Ctrl-/ to trigger line, close it using same keystroke
  if unite.buffer_name =~# '^search_file'
    imap <buffer> <C-_> <Plug>(unite_exit)
  endif
endfunction

" Start in insert mode
let g:unite_enable_start_insert = 1

" Enable short source name in window
" let g:unite_enable_short_source_names = 1

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
let g:unite_split_rule = "botright"

" Shorten the default update date of 500ms
let g:unite_update_time = 200

let g:unite_source_file_mru_limit = 1000
let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_abbr_highlight = 'TabLine'

let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

" For ack.
if executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
  " Match whole word only. This might/might not be a good idea
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack')
  let g:unite_source_grep_command = 'ack'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
  let g:unite_source_grep_recursive_opt = ''
endif

"-------------------------------------------------------------------
" Unite session
"-------------------------------------------------------------------

" Save session automatically.
let g:unite_source_session_enable_auto_save = 1

" Pop up session selection if no file is specified
" TODO: Why does this not work when Vim isn't run from tmux???!
autocmd MyAutoCmd VimEnter * call s:unite_session_on_enter()
function! s:unite_session_on_enter()
  if !argc() && !exists("g:start_session_from_cmdline")
    Unite -buffer-name=sessions session
  endif
endfunction

"-------------------------------------------------------------------
"  NerdCommenter
"-------------------------------------------------------------------

" Always leave a space between the comment character and the comment
let NERDSpaceDelims=1

"-------------------------------------------------------------------
" YouCompleteMe
"-------------------------------------------------------------------

let g:ycm_autoclose_preview_window_after_completion=1

"-------------------------------------------------------------------
"  Auto commands
"-------------------------------------------------------------------

" Turn on cursorline only on active window
augroup MyAutoCmd
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter,BufRead * setlocal cursorline
augroup END

" q quits in certain page types. Don't map esc, that interferes with mouse input
autocmd MyAutoCmd FileType help,quickrun
      \ if (!&modifiable || &ft==#'quickrun') |
      \ nnoremap <silent> <buffer> q :q<cr>|
      \ nnoremap <silent> <buffer> <esc><esc> :q<cr>|
      \ endif
autocmd MyAutoCmd FileType qf nnoremap <silent> <buffer> q :q<CR>

" json = javascript syntax highlight
autocmd MyAutoCmd FileType json setlocal syntax=javascript

" Enable omni completion
augroup MyAutoCmd
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
augroup END

"-------------------------------------------------------------------
"  UltiSnips
"-------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

"--------------------------------------------------------------------------
"  NERDTree
"--------------------------------------------------------------------------
nmap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap <leader>N :NERDTreeClose<CR>
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>

let NERDTreeChDirMode=0

let NERDTreeMouseMode=2

let NERDTreeShowHidden=1

let NERDTreeKeepTreeInNewTab=1

let g:nerdtree_tabs_open_on_gui_startup=0

let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
" let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$',]

"--------------------------------------------------------------------------
"python
"--------------------------------------------------------------------------

let python_highlight_all = 1
let python_highlight_builtins = 1

au FileType python syn keyword pythonDecorator True None False self
au FileType python syn keyword pythonConditional if elif else

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

" if exists('+colorcolumn')
    " set colorcolumn=80
" else
    " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif

set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"remove all white space on save
autocmd BufWritePre * :%s/\s\+$//e

"--------------------------------------------------------------------------
" easy motion
"--------------------------------------------------------------------------
let g:EasyMotion_leader_key = '<Leader><leader>'

"--------------------------------------------------------------------------
"  Ctrl-P
"--------------------------------------------------------------------------
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

"--------------------------------------------------------------------------
"  Syntastic
"--------------------------------------------------------------------------

let g:syntastic_python_checkers=['flake8']
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

"--------------------------------------------------------------------------
"  Flake8
"--------------------------------------------------------------------------

let g:flake8_builtins="_,apply"
let g:flake8_ignore="E501,W293"
" autocmd BufWritePost *.py call Flake8()
let g:flake8_cmd="/usr/local/bin/flake8"
