call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'  " TODO: see how this can be improved
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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

set foldenable     " enable folding
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set clipboard+=unnamedplus

set number 
set relativenumber
set wildmenu
set autowrite

set background=dark

let mapleader = ","

"airline
let g:airline_powerline_fonts = 1

" quality of life
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" vim-go
let g:go_fmt_command = "goimports"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
