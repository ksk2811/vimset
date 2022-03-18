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
set wmnu            "탭완성시 자동완성목록보여줌
set splitbelow
set splitright
set noet
"set et             "tab 대신 sts에 설정한 값만큼 스페이스 입력
set smarttab        "sw, ts sts를 참조하여 탭과 백스페이스 키 동작 보조
set ts=8            "탭을 스페이스로 표시		
set sw=8            "정렬과 인뎅팅시 사용할 스페이스
set sts=8           "et가 설정되어 있으면 tab을 지정한 스페이스 수로 입력
set ai
set si
"set cindent
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
