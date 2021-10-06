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
set enc=utf-8
set fenc=utf-8
set fencs=ucs-bom,utf-8,cp949,euc-kr,latin1

"ctags, cscope
"set tags=./,../

"if filereadable("./cscope.out")
"cs add ./cscope.out
"endif

"etc
set nocompatible    " 오리지날 VI와 호환하지 않음
set nu
set novisualbell    "화면 깜빡임 끔
set nuw=4           "줄 번호 표시 너비 설정
set ts=8
set sw=8
set wmnu            "탭완성시 자동완성목록보여줌
set splitbelow
set splitright
set noet            "탭->공백변환 사용안함
set smarttab        "백스페이스로 지울때 탭단위	
"set cindent
set ai
set si
set nostartofline   "밑줄로 이동할 때 커서가 가장 왼쪽의 시작점으로 이동하지 못하게 한다"
set laststatus=2    "하단상태바출력(0: 표시X, 1: 창이 두개 이상일때 표시, 2: 항상표시)
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
set bs=indent,eol,start

"map
nnoremap j gj
nnoremap k gk
nmap <F10> ma:%!git blame %<CR>
map <F11> :<C-u>call CopyWord()<CR> :vnew <C-r>".diff \| .!git show <C-r>"<CR>
"vmap <C-J> :norm i//<CR>   "블럭잡힌 각 라인에 // 주석추가
"vmap <C-K> :norm 0xx<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" highlight DoubleClick
nmap <2-LeftMouse> *#

func CopyWord()
        let column = getline('.')[col('.')]
        if column == "\0" "if next col is null
                normal vBy
        elseif match(column, '\s') == 0 "if next col is empty
                normal vBy
        endif
        normal evBy 
endfunc
