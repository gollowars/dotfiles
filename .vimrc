if &compatible
  set nocompatible " Be iMproved
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
"call dein#add('jacoborus/tender.vim')
call dein#add('gosukiwi/vim-atom-dark')


"call dein#add('junegunn/fzf.vim')
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

" dart
call dein#add('dart-lang/dart-vim-plugin')

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

"dart
let g:dart_format_on_save = 1

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
set tabstop=2 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set list listchars=tab:>- " 不可視文字を標示

"if (has("termguicolors"))
" set termguicolors
"endif

" テキスト背景色
"au ColorScheme * hi Normal ctermbg=none
" 括弧対応
"au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
" スペルチェック
":au Colorscheme * hi SpellBad ctermfg=23 cterm=none ctermbg=none

"set background=dark

syntax on "コードの色分け
set t_Co=256
colorscheme atom-dark-256

" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
"highlight CursorColumn ctermbg=#404040

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" #####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"Leader
let mapleader="\<Space>"
nnoremap <Leader>b :echo "Good"<CR>


"plugin
filetype plugin on



