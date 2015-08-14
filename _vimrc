
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set ic
set hls
set is

set sessionoptions-=curdir
set sessionoptions+=sesdir

let mapleader = ","                   "Set mapleader

"""""""""""""""""""""""""""""""""""""""
" set include path
"""""""""""""""""""""""""""""""""""""""
autocmd FileType c,cpp set path=.,/usr/include,/usr/local/include 

"""""""""""""""""""""""""""""""""""""""
" taglist&ctags
"
" ctags -R -f tags --c-kinds=+p --fields=+iaS --extra=+q .
" ctags -R -f ~/.vim/systags --c-kinds=+p --fields=+S --extra=+q /usr/include /usr/local/include /usr/java/default/include
"""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd='ctags'            "ctags命令的位置
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右边侧窗口中显示taglist窗口
let Tlist_Sort_Type = 'name'           "taglist以tag名字进行排序
let Tlist_Auto_Open = 0                "手动打开taglist
let Tlist_File_Fold_Auto_Close = 1     "只显示当前文件的tag
let Tlist_Process_File_Always = 0      "如果为1，则taglist会始终解析文件中的tag, 而不管有没有打开
let Tlist_Use_Horiz_Window = 0         "竖直显示taglist
let Tlist_WinWidth = 30                "taglist窗口宽度
"let Tlist_WinHeight = 500

set tags+=~/.vim/systags

"shortcuts
map <silent> <F9> :TlistToggle<cr>

"""""""""""""""""""""""""""""""""""""""
" bufexplorer
"
" 缓冲区切换 [n] + ctrl + ^
"
"""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber 

"""""""""""""""""""""""""""""""""""""""
" NERDTree for winmanager
"
"""""""""""""""""""""""""""""""""""""""
let g:NERDTree_title = "[NERDTree]" 
function! NERDTree_Start() 
    exe 'NERDTree'
endfunction 

function! NERDTree_IsValid() 
    return 1 
endfunction

function! _wmtoggle()
    exe "WMToggle"
    if IsWinManagerVisible()
        exe "q"
    endif
endf
nmap <silent> <leader>wm :call _wmtoggle() <cr>
nmap <silent> <leader>nf :NERDTreeFind <cr>

"""""""""""""""""""""""""""""""""""""""
" winmanager
"
" 打开管理窗口 ,wm
"""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "NERDTree" "|TagList|BufExplorer 这里配置的仅仅是位于左边的winmanager窗口
let g:winManagerWidth = 30
let g:defaultExplorer = 1 
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
"nmap <silent> <leader>wm :WMToggle<cr>

"""""""""""""""""""""""""""""""""""""""
" lookupfile
"
"""""""""""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("tags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"tags"'
endif
nmap <silent> <leader>lt : silent LUTags<cr>
nmap <silent> <leader>lb : silent LUBufs<cr>
nmap <silent> <leader>lw : silent LUWalk<cr>

"""""""""""""""""""""""""""""""""""""""
" cscope
"
" cscope -Rbq
"""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set csprg=cscope
    set csto=1
    set cst
    set nocsverb

    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif

    set csverb
endif

" find this c symbol
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" find this definition
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" find functions called by this function
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" find functions calling this function
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" find this text string
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" find this egrep pattern
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" find this file
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" find files #including this file
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

"""""""""""""""""""""""""""""""""""""""
" quickfix
"""""""""""""""""""""""""""""""""""""""
" autocmd FileType c,cpp
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr>

"在当前文件中快速查找光标下的单词
nmap <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>

"""""""""""""""""""""""""""""""""""""""
" syntax highlight
" let @/=""
"""""""""""""""""""""""""""""""""""""""
filetype on                          "filetype detection
filetype plugin on
filetype indent on

"""""""""""
" paste toggle
"""""""""
set pastetoggle=<F2>

syntax enable                         "syntax highlight
syntax on

colorscheme darkblue      "color 

"""""""""""""""""""""""""""""""""""""""
" completion
" omnicompletion, code_completion (supertab conflict with code_completion)
"""""""""""""""""""""""""""""""""""""""
set nocp                              "close compatible mode for vi
"set completeopt=longest,menu          "close preview, default:menu,preview

inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>" 

" 自动关闭提示窗口
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" code_complete
let g:completekey = "<tab>"

"""""""""""""""""""""""""""""""""""""""
" showmarks
"
" `a 跳转到标记a
" ms 设计标记s
" :delmarks s 删除标记s
"""""""""""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1               "Show which marks
let showmarks_include ="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" " Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"      "Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1

""""""""""""""""""""""""""""""""""""""
" fold
"
" 折叠方法: syntax, indent, diff, marker, expr
"
" "zi 打开关闭折叠
" "zv 查看此行
" zm 关闭折叠
" zM 关闭所有
" zr 打开
" zR 打开所有
" zc 折叠当前行
" zo 打开当前折叠
" zd 删除折叠
" zD 删除所有折叠
""""""""""""""""""""""""""""""""""""""
autocmd FileType c,cpp  setl foldmethod=syntax | setl nofoldenable

""""""""""""""""""""""""""""""""""""""
" line number
""""""""""""""""""""""""""""""""""""""
"autocmd FileType c,cpp set number
autocmd FileType * set number

""""""""""""""""""""""""""""""""""""""
" tab: 4 space
""""""""""""""""""""""""""""""""""""""
set ts=4                             " 用四个空格代替一个TAB
set expandtab                        " 在缩进时使用空格代替TAB
set autoindent                       " 敲回车时自动缩进
set shiftwidth=4                     " 敲回车时自动缩进4个空格, 而不是8个

""""""""""""""""""""""""""""""""""""""
" .file.swp, file~
""""""""""""""""""""""""""""""""""""""
set directory=~/tmp,/var/tmp,/tmp
set nobackup
""""""""""""""""""""""""""""""""""""""
" generate source file copyrigt
""""""""""""""""""""""""""""""""""""""
function! _comment_header_template()
    "call setline(1,"/**")
    let $l = line(".") - 1
    call append($l+0,"/**")
    call append($l+1," * author: shun.zhang@aispeech.com")
    call append($l+2," * date:   ".strftime("%c"))
    call append($l+3," * file:   ".expand("%"))
    call append($l+4," * desc:   ")
    call append($l+5," */")
endf
nmap  <leader>_cpy : call _comment_header_template()<CR><Esc>:$<Esc>o

""""""""""""""""""""""""""""""""""""""
" 函数注释 
""""""""""""""""""""""""""""""""""""""
function! _copyright_template_c()
    "call setline(1,"/**")
    let $l = line(".") - 1
    call append($l+0,"/*******************************************************************************")
    call append($l+1, "* Function    : ")
    call append($l+2, "* Description : ")
    call append($l+3, "* Author      : hubertliu")
    call append($l+4, "* Date        : ".strftime("%c"))
    " .strftime("%c")")
    call append($l+5, "* Input       : ")
    call append($l+6, "* Output      : ")
    call append($l+7, "* Return      : ")
    call append($l+8, "*------------------------------------------------------------------------------*")
    call append($l+9, "* Record      :")
    call append($l+10, "*******************************************************************************/")
endf
nmap <leader>_bb : call _copyright_template_c()<CR>

""""""""""""""""""""""""""""""""""""""
" lua函数注释 
""""""""""""""""""""""""""""""""""""""
function! _copyright_template_lua()
    "call setline(1,"/**")
    let $l = line(".") - 1
    call append($l+0,"--------------------------------------------------------------------------------")
    call append($l+1, "-- Function    : ")
    call append($l+2, "-- Description : ")
    call append($l+3, "-- Author      : hubert.liu")
    call append($l+4, "-- Date        : ".strftime("%c"))
    " .strftime("%c")")
    call append($l+5, "-- Input       : ")
    call append($l+6, "-- Output      : ")
    call append($l+7, "-------------------------------------------------------------------------------")
    call append($l+8, "-- Record      :")
    call append($l+9,"--------------------------------------------------------------------------------")
endf
nmap <leader>_lf : call _copyright_template_lua()<CR>


""""""""""""""""""""""""""""""""""""""
" lua文件头注释 
""""""""""""""""""""""""""""""""""""""
function! _source_head_comment_template_lua()
    "call setline(1,"/**")
    let $l = line(".") - 1
    call append($l+0,"--------------------------------------------------------------------------------")
    call append($l+1, "-- Copyright (C), AISpeech Tech. Co., Ltd.")
    call append($l+2, "-- ")
    call append($l+3, "-- FileName    : ")
    call append($l+4, "-- Author      : hubert.liu")
    call append($l+5, "-- Date        : ".strftime("%c"))
    call append($l+6, "-- Description : ")
    call append($l+7, "--------------------------------------------------------------------------------*")
    call append($l+8, "-- Record      : ")
    call append($l+9,"--------------------------------------------------------------------------------")
endf
nmap <leader>_lh : call  _source_head_comment_template_lua()<CR>


""""""""""""""""""""""""""""""""""""""
" 文件头注释 
""""""""""""""""""""""""""""""""""""""
function! _source_head_comment_template()
    "call setline(1,"/**")
    let $l = line(".") - 1
    call append($l+0,"/*******************************************************************************")
    call append($l+1, "* Copyright (C), 2008-2014, AISpeech Tech. Co., Ltd.")
    call append($l+2, "* ")
    call append($l+3, "* FileName    : ")
    call append($l+4, "* Author      : hubert.liu")
    call append($l+5, "* Date        : ".strftime("%c"))
    call append($l+6, "* Description : ")
    call append($l+7, "*------------------------------------------------------------------------------*")
    call append($l+8, "* Record      : ")
    call append($l+9, "*******************************************************************************/")
endf
nmap <leader>_hh : call  _source_head_comment_template()<CR>


""""""""""""""""""""""""""""""""""""""
" generate c header file embryonic 
""""""""""""""""""""""""""""""""""""""
function! _c_header_template()
    let $h= substitute(toupper(expand("%:p:t")),"\\.","_","g")."_"
    let $l = line(".") - 1
    call append($l+0,"#ifndef ".$h)
    call append($l+1,"#define ".$h)
    call append($l+2,"")
    call append($l+3,"")
    call append($l+4,"#ifdef __cplusplus")
    call append($l+5,"extern \"C\" {")
    call append($l+6,"#endif")
    call append($l+7,"")
    call append($l+9,"")
    call append($l+10,"#ifdef __cplusplus")
    call append($l+11,"}")
    call append($l+12,"#endif")
    call append($l+13,"#endif")
endf
nmap <leader>_hdr : call _c_header_template()<CR><Esc>dd
":$<Esc>o

"""""""""""""""""""""""""""""""""""""
" update ctags, cscope
"""""""""""""""""""""""""""""""""""""
function! _ctags_cscope_update()
    exe "!echo ctags ...; rm -f tags; ctags -R -f tags --c-kinds=+p --fields=+iaS --extra=+q .; echo cscope ...; rm -f cscope.*; cscope -Rbq;"
    TlistUpdate
endf
nmap <leader>_ct : call _ctags_cscope_update()<CR><Esc>

"""""""""""""""""""""""""""""""""""""
" refresh ctags, cscope, taglist, filelist automatically
"""""""""""""""""""""""""""""""""""""
"autocmd BufWritePost,FileWritePost *.h,*.c,*.cpp
" \ if filereadable("tags") |
" \  exe "silent !rm -f tags; ctags -R -f tags --c-kinds=+p --fields=+iaS --extra=+q ." |
" \ endif |
" \ if filereadable("cscope.out") |
" \  exe "silent !rm cscope.*; !cscope -Rbq" |
" \ endif |
" \ TlistUpdate
set guifont=Courier-new\ 14

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

"必不可少，在VIM的编辑窗口树状显示文件目录
Plugin 'The-NERD-tree'

"NERD出品的快速给代码加注释插件，选中，`ctrl+h`即可注释多种语言代码；
Plugin 'The-NERD-Commenter'

Plugin 'lua.vim'

Plugin 'lua_omni'

"Plugin 'luainspect.vim'

Plugin 'vim-misc'

Plugin 'ctags.vim'

Plugin 'winmanager'

Plugin 'cscope.vim'

Plugin 'taglist.vim'

"VIM自动补全插件
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required

" All of your Plugins must be added before the following line
filetype plugin indent on    " required

