call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'valloric/youcompleteme', {'do': './install.py'}
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug '907th/vim-auto-save'
Plug 'gavinbeatty/dragvisuals.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tomlion/vim-solidity'
call plug#end()

filetype plugin indent on
set backspace=indent,eol,start
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set bs=2
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces

set foldenable          " enable folding
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set clipboard+=unnamedplus

set number 
set relativenumber
set wildmenu

vmap  <expr>  <c-h>   DVB_Drag('left')  
vmap  <expr>  <c-l>  DVB_Drag('right') 
vmap  <expr>  <c-j>   DVB_Drag('down')  
vmap  <expr>  <c-k>     DVB_Drag('up')    
vmap  <expr>  D        DVB_Duplicate()   

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

let g:ycm_python_binary_path = '/usr/bin/python'

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_no_updatetime = 1
" let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save_events = ["InsertLeave", "TextChanged"]

set background=dark
let g:airline_powerline_fonts = 1

" Keybindings
nnoremap <CR> :noh<CR><CR>

""" Syntastic """
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

