" tehftw's .vimrc 
" Wed Feb 21 23:23:08 STD 2018

" TODO: 
"   add autosave after leaving insert
"   highlight whitespace at the end of line
"   do stuff about buffering: ergonomics of using buffers and tabs and windows
"   do something about sessions - easily saving and getting back to them


" reddit said that 'set nocompatible' is unneeded
" dasdsad__dsadsad_dsad
" Vundle config: has to be at the start
" {


filetype off " required by Vundle
        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        "alternatively, pass a path where Vundle should install plugins
        "call vundle#begin('~/some/path/here')

		Plugin 'file://home/teh/.vim/vimorg-scripts/slimv'
        " let Vundle manage Vundle, required
        Plugin 'VundleVim/Vundle.vim'
	
		Plugin 'bkad/CamelCaseMotion'
        " The following are examples of different formats supported.
        " Keep Plugin commands between vundle#begin/end.
        " plugin on GitHub repo
        Plugin 'tpope/vim-fugitive'
        " plugin from http://vim-scripts.org/vim/scripts.html
        " Plugin 'L9'
        " Git plugin not hosted on GitHub
        "Plugin 'git://git.wincent.com/command-t.git'
        " git repos on your local machine (i.e. when working on your own plugin)
        " Plugin 'file:///home/gmarik/path/to/plugin'
        
		" The sparkup vim script is in a subdirectory of this repo called vim.
        " Pass the path to set the runtimepath properly.
        Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
        " Install L9 and avoid a Naming conflict if you've already installed a
        " different version somewhere else.
        " Plugin 'ascenator/L9', {'name': 'newL9'}
   
        " Markdown
        Plugin 'godlygeek/tabular'
        Plugin 'plasticboy/vim-markdown'

        " scrooloose/NerdTree
        Plugin 'scrooloose/nerdTree'


		" vlime - for lisp
		Plugin 'l04m33/vlime', {'rtp': 'vim/'} 
		
		
		
		Plugin 'majutsushi/tagbar'
        "Disabling because shitty autocomplete pisses me off
        " Plugin 'justmao945/vim-clang'

        " gruvbox coloscheme:
        "Plugin 'morhetz/gruvbox'

        " Syntastic - syntax checking and stuff
        Plugin 'vim-syntastic/syntastic'

		Plugin 'wlangstroth/vim-racket'
        " vim-colorschemes
        Plugin 'flazz/vim-colorschemes'
        " cycling colorschemes
        " (Disabled) Plugin 'vim-scripts/CycleColor'


        " RUST
        " Vundle plugin: Rust.vim
        Plugin 'rust-lang/rust.vim'        " All of your Plugins must be added before the following line

        " plugin: simply cargo bindings
        Plugin 'timonv/vim-cargo'


		" Superman - for better man pages
		Plugin 'jez/vim-superman'

		

		" REPL
		Plugin 'https://gitlab.com/HiPhish/repl.nvim/'
        

		" gdb :
		Plugin 'https://github.com/sakhnik/nvim-gdb'
		Plugin 'https://github.com/vim-scripts/Conque-GDB'

        call vundle#end()            " required
        filetype plugin indent on    " required
        " To ignore plugin indent changes, instead use:
        "filetype plugin on
        "
        " Brief help
        " :PluginList       - lists configured plugins
        " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
        " :PluginSearch foo - searches for foo; append `!` to refresh local cache
        " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
        "
        " see :h vundle for more details or wiki for FAQ
        " Put your non-Plugin stuff after this line
" }


" { CamelCaseMotion
	map <silent> <C-Right> <Plug>CamelCaseMotion_w
	map <silent> <C-Left> <Plug>CamelCaseMotion_b
" }

" Clipboard {
    let g:clipboard = {
          \   'name': 'ClipboardFromNeovimHelp',
          \   'copy': {
          \      '+': 'tmux load-buffer -',
          \      '*': 'tmux load-buffer -',
          \    },
          \   'paste': {
          \      '+': 'tmux save-buffer -',
          \      '*': 'tmux save-buffer -',
          \   },
          \   'cache_enabled': 1,
          \ }
    
    " {not needed in nvim} set clipboard=exclude:.* " disables Xserver clipboard, for faster startup
    "because otherwise my ViM takes a whole second to start up xD
    
" }


" Environment {
	" Basics {
        " {not needed in nvim} set term=$TERM   " make arrow and other keys work
        set mouse=a      " enable mouse in all modes
        set wildmenu     " nice menu with suggestions for command arguments
    " }
" }

" Statusline {
set statusline=%m%r%h%w%L[%{&ff}]%y[%p%%][%l,%v]%F
" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%l,%v]
"                | | | | |  |   |      |  |     |    |
"                | | | | |  |   |      |  |     |    +-- current column
"                | | | | |  |   |      |  |     +-- current line
"                | | | | |  |   |      |  +-- current % into file
"                | | | | |  |   |      +-- current syntax
"                | | | | |  |   +-- current fileformat
"                | | | | |  +-- number of lines
"                | | | | +-- preview flag in square brackets
"                | | | +-- help flag in square brackets
"                | | +-- readonly flag in square brackets
"                | +-- rodified flag in square brackets
"                +-- full path to file in the buffer
" }


" {
"set listchars=tab:--,trail:.,eol:¬,extends:>,precedes:<
set listchars=tab:»-,trail:·,extends:»,precedes:«
set list
" }





command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" General {
	set number
	colorscheme railscasts
	syntax on " syntax highlighting
	filetype on " use the type of file
	set ruler " show linecount always
	set hlsearch " highlights after searching
	set title " display titre of file
	set ignorecase " case insesitive search by default
	" set cursorline " I think it shows the line cursor is on
" }



                

" TabKey, formatting {
	set autoindent " indent same level as last line
	set tabstop=4 " display tabs as this many spaces
	set softtabstop=4 " lets backspace delete indent	
	set shiftwidth=4 " displays tab as 4 spaces
	" set expandtab , no, keep tabs as is, you clown
    " As suggested by /r/vim wiki, I changed tabstop back to the default 8
    
" }


" Neovim {
    " RemapKeys {
       " <esc> to exit terminal
       :tnoremap <Esc> <C-\><C-n> 

    " }
" }

" RemapKeys {
	nmap <F8> :TagbarToggle<CR>
    " remap colon and semicolon for easier use
    " nnoremap: Normal
    nnoremap ; :
	
	" swap '(' with '['   --- no longer needed because I changed keyboard
	" layout
	"noremap! ( [
	"noremap! ) ]
	"noremap! [ (
	"noremap! ] )
	"noremap ( [
	"noremap ) ]
	"noremap [ (
	"noremap ] )
	"tnoremap ( [
	"tnoremap ) ]
	"tnoremap [ (
	"tnoremap ] )

    " <j> and <k> to move both cursor and screen
    " noremap: Normal, Visual, Select, Operator-pending
    " NOTE: not stable - mostly when pressing <Down>, 
    " it tends to be very jumpy and move the cursor all around
    " Edit: Now it's stable. Probably too many spaces at the end
    "noremap <Down> <C-e>j
    "noremap <Up> <C-y>k

    " scroll with <ctrl>+<Up>/<ctrl + down>
    noremap <C-Down> <C-e>
    noremap <C-Up> <C-y>

    " makes dot "." work with visually selected lines by default
    " only in visual mode
    xnoremap . :norm.<CR> 


	" Go back one tab
	noremap gb gT

    " When F5 is pressed, a numbered list of file names is printed, and the user needs to type a single number based on the 'menu' and press Enter. The 'menu' disappears after choosing the number so it appears only when you need it <-- Happily infoanarchised from vim-wiki
    nnoremap <F5> :buffers<CR>:buffer<Space>
    nnoremap <F6> :buffers<CR>:<Space>


    " move to prev tab with <gb> <ctrl+tab>
    " noremap  <g><b> :tabprevious<CR>
    " inoremap <g><b> :tabprevious<CR>
    " cnoremap <g><b> :tabprevious<CR>
    "    noremap <C-S-Tab> :<C-U>tabNext<CR>
    "    inoremap <C-S-Tab> <C-\><C-N>:tabNext<CR>
    "    cnoremap <C-S-Tab> <C-U>:tabNext<CR>


" }


" SYNTASTIC {
    
    " I will probably remove that junk
    "set statusline+=%#warninggmsg#
    "set statusline+=%#{SyntasticStatuslineFlag()}#
    "set statusline+=%*

    " JUST STAY IN PASSIVE MODE YOU FUCKER
    let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": ["ruby"],
        \ "passive_filetypes": ["puppet"] }

    let g:syntastic_always_populate_loc_list = 1
    
    " auto open, auto close 
    let g:syntastic_auto_loc_list = 1
    
    " don't check on save&close
    let g:syntastic_check_on_wq = 0
    

    " don't auto-check on saving nor on open
    let g:syntastic_check_on_open = 0

    " command to check:
    :command Sch SyntasticCheck
" }



" NERDTree {
    " automatically open NerdTree
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    " open NerdTree when opening a directory with ViM
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

    " show hidden(dot files) by default
    let NERDTreeShowHidden=1

    " Hotkey: Ctrl+N for NerdTre
    map <C-n> :NERDTreeToggle<CR>

" }





