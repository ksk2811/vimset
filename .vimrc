syntax on
filetype on

"mouse
if has('mouse')
	set mouse=a
endif

set t_Co=256
color inkpot
"color slate

"encoding
set fencs=ucs-bom,utf-8,cp949,euc-kr,latin1
"set fenc=utf-8
"set enc=utf-8

set fileformats=unix

"ctags, cscope
"set tags=./,../

"if filereadable("./cscope.out")
"cs add ./cscope.out
"endif

"etc
set title           "타이틀바에 현재 편집중인 파일을 표시
set nocompatible    "오리지날 VI와 호환하지 않음
set nu
set novisualbell    "경고용 화면 깜빡임 끔
set nuw=4           "줄 번호 표시 너비 설정
set wmnu            "탭 완성시 자동완성 목록 보여줌
set splitbelow
set splitright
set noet
"set et             "tab 대신 sts에 설정한 값만큼 스페이스 입력
"set sts=8          "et가 설정되어 있으면 tab 대신 지정한 수의 스페이스 입력
set ts=8            "직접 탭 입력 시 몇 개의 스페이스로 표시할지 설정. :retab을 입력하면 파일 내의 탭을 tabstop 만큼의 스페이스로 바꿔준다.
set sw=8            "정렬과 인덴팅시 사용하는 탭을 몇 개의 스페이스로 표시할지 설정
set smarttab        "sw, ts sts를 참조하여 탭과 백스페이스 키 동작 보조
set ai
set si
"set cindent
set nostartofline   "밑줄로 이동할 때 커서가 가장 왼쪽의 시작점으로 이동하지 못하게 한다
set laststatus=2    "하단 상태바출력(0: 표시X, 1: 창이 두개 이상일때 표시, 2: 항상표시)
"set statusline+=%{&fileencoding}
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ Encoding:\ %{&fileencoding}\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set hlsearch
"set incsearch      "찾는글자칠때마다 찾은글자표시
set ic              "대소문자 무시
set scs             "대문자로 입력하면 대문자 검색
set showmatch       "매칭되는 괄호보이기  
"set pt=<Ins>       "인서트키로 paste, nopate 상태전환
set nowrap          "자동줄바꿈X
set nowrapscan      "파일끝에 도달하면 찾지않음
set ruler	    "커서 위치 정보 표시
set ttymouse=xterm2 "마우스스크롤
set noeol           "파일 맨 끝의(EOL) 개행문자 제거하기
"set cuc            "커서가 있는 곳을 세로로 하이라이트
set cul             "커서가 있은 곳을 가로로 하이라이트
set bs=indent,eol,start  "indent : 오토 인덴트를 지울 수 있다. 가령 인덴팅에 4개의 스페이스를 사용하고 있다면, 백 스페이스를 한 번 눌러서 인덴팅의 스페이스 4개를 지울 수 있다.
                         "eol : end of line을 지워서, 두 줄을 하나로 합칠 수 있다.
                         "start : 행의 시작 지점을 지울 수 있다.
                         "eol과 start를 함께 설정하면 백 스페이스로 이번 줄을 다 지우고 나서, 더 누르면 바로 윗줄 제일 오른쪽 글자부터 지우기 시작한다.
"map
nnoremap j gj
nnoremap k gk
nmap <F5> :PlugInstall<CR>
nmap <F6> :VimGameCodeBreak<CR>
nmap <F10> ma:%!git blame %<CR>`a
map <F11> :<C-u>call CopyHash()<CR> :vnew <C-r>".diff \| %!git show <C-r>"<CR>
"vmap <C-J> :norm i//<CR>   "블럭잡힌 각 라인에 // 주석추가
"vmap <C-K> :norm 0xx<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/  "라인 마지막 공백 붉은색 표시

nmap <2-LeftMouse> *#  "highlight DoubleClick

function! CopyHash()
    let l:line = getline('.')
    let l:word = split(l:line)[0]
    let @" = l:word
endfunction

func CopyWord()
        let column = getline('.')[col('.')]
        if column == "\0" "if next col is null
                normal vBy
        elseif match(column, '\s') == 0 "if next col is empty
                normal vBy
        endif
        normal evBy 
endfunc

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Specify a directory for plugins
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
let curl_exists=expand('curl')
if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/autoload')
Plug 'johngrib/vim-game-code-break'
call plug#end()
