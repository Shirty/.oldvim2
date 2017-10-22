" Author: Sebastian Weilhammer
" Description: Rewrite of my vimrc with compatibility with nvim also... I
" couldn't stand looking at my old one anymore!!
" Notes:
" - I used to document most lines... found out how to use help more efficiently ;)
" TODO
" - figure out why todo's are causing wrapping of text
" - remove temporary folder created in each directory
" - figure out everything with ctrl p for easy access to files
" - hidden swp files? enough?

" TODO look into automating if i need to install on multiple pc's? not usual so hardcoded for now
let plugpath = ''
" plug path setup {{{
if has('win32')
    if has('nvim')
        let plugpath = expand($LOCALAPPDATA).'\nvim\plugged'
    else
        let plugpath = '~/vimfiles/plugged'
    endif
endif
" }}}
" TODO: check why by default this does not happen (I think i'm refering to the expand command...)
call plug#begin(expand(plugpath))

" This works? other does not TODO
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
" Plug 'jlangmiao/auto-pairs'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'Valloric/YouCompleteMe'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" Plug 'Raimondi/delimitMate'
" Plug 'vim-airline/vim-airline'
" Plug 'https://github.com/justinj/vim-pico8-syntax.git' " Not sure why but had to have full link here look this up TODO
" Plug 'equalsraf/neovim-gui-shim' " for the gui? figure out what is going wront
" Plug 'tpope/vim-surround'
" Plug 'c.vim'

call plug#end()

let mapleader=","
" let maplocalleader="," " never use it..?

set backspace=indent,eol,start " backspace behaviour
set number
set relativenumber " TODO find out why i put this after number

" number toggle code {{{
function! NumberToggle()
    if (&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
" }}}
nnoremap <C-n> :call NumberToggle()<cr>

if has("gui_running")
    if has("gui_win32")
        set guifont=Consolas:h10:b:cANSI
    endif
endif

colorscheme darkblue
set cursorline

set path+=** " recursive search

nnoremap <leader>n :noh<cr> " quick remove hightlight

set visualbell " setting visual bell instead of sound
set t_vb= " set visual bell to nothing

set encoding=utf-8 " why not? mainly for YouCompleteMe

set expandtab " expand tab to spaces
set tabstop=4 " amount of spaces to expand to
set shiftwidth=4 " amount of spaces inserted for indentation etc

" TODO: need a better way to detect airline
" TODO: reset when i know better what to do 
" if !exists(":Plug") 
"     set statusline=%f 	" Path to the file
"     set statusline+=%= 	" Switch to the right side
"     set statusline+=%l	" Current line
"     set statusline+=/	" Seperator
"     set statusline+=%L	" Total lines
" endif

" quick edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>eV :e $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
nnoremap <c-g> <c-]> " mainly because i'm used to doing this in vs and still use vs

" quick save/exit
nnoremap <leader>s :w<cr>
nnoremap <c-s> :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>

augroup general
	autocmd!
	" if i want to move to directory of file i am currently working on by default
	" --> autocmd BufEnter * silent! lcd %:p:h
augroup END

" YCM settings
nnoremap <m-g> :YcmCompleter GoTo<cr>

" vimtex
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '=reuse-instance -forward-search @text @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" to allow for project specific settings
" set exrc
" set secure
"
augroup vimscript
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
    " Commenting "TODO: I think i need to look add local here
	" autocmd FileType vim nnoremap <leader>c 0i" <esc>
    " autocmd FileType vim vnoremap <c-c> 0i" <esc>
augroup END

augroup cpp
	autocmd!
    " just for cpp i want to have specific settings
    autocmd FileType cpp,c setlocal colorcolumn=110
	autocmd FileType cpp,c setlocal expandtab
	autocmd FileType cpp,c setlocal tabstop=4
	autocmd FileType cpp,c setlocal shiftwidth=4
    autocmd FileType cpp,c setlocal cindent
augroup END

augroup pico8
    autocmd FileType pico8 setlocal expandtab
    autocmd FileType pico8 setlocal tabstop=2
    autocmd FileType pico8 setlocal shiftwidth=2
augroup END

