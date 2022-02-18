"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/gollowars/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/gollowars/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/gollowars/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')


"call dein#add('tomasr/molokai')
"call dein#add('altercation/vim-colors-solarized')
call dein#add('jacoborus/tender.vim')

"構文チェックを行う。
call dein#add('scrooloose/syntastic')
"()を補間する。
call dein#add('Townk/vim-autoclose')
"() 色付け:
call dein#add('itchyny/lightline.vim')
"インデントの色付け
call dein#add('Yggdroot/indentLine')
" 末尾の全角と半角の空白文字を赤くハイライト
call dein#add('bronson/vim-trailing-whitespace')



" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------



"molokai
"let g:molokai_original = 1

"基本設定
"

" clipboardとyank共有設定
set clipboard+=unnamed

"" ####Encode####
" 下記の指定は環境によって文字化けする可能性があるので適宜変更する
set encoding=UTF-8 "文字コードをUTF-8にする
set fileencoding=UTF-8 "文字コードをUTF-8にする
set termencoding=UTF-8 "文字コードをUTF-8にする

" #####表示設定#####"
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=2 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set list listchars=tab:>- " 不可視文字を標示

if (has("termguicolors"))
 set termguicolors
endif

colorscheme tender

let g:lightline = { 'colorscheme': 'tender' }
"let g:airline_theme = 'tender'


set t_Co=256
"### lightlineの設定
set laststatus=2
" #####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る




