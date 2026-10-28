"syntax on     "문법 강조를 무조건 활성화 (기존 사용자 정의 색상 무시 가능)
syntax enable  "문법 강조를 활성화하되, 이미 존재하는 사용자 색상 설정은 유지
filetype on

"mouse
if has('mouse')
	set mouse=a
endif

set t_Co=256
color inkpot
"color slate

"encoding
set enc=utf-8                    "Vim 내부(메모리 버퍼) 인코딩. 읽은 파일은 이 인코딩으로 변환되어 편집되며, 메시지·상태줄·레지스터도 이 인코딩을 쓴다
set fencs=utf-8,euc-kr,Shift-JIS "파일을 열 때 앞에서부터 시도할 인코딩 후보. 판별이 엄격한(틀리면 실패하는) 인코딩을 앞에 둔다
set fileformats=unix,dos

"ctags, cscope
"set tags=./,../

"if filereadable("./cscope.out")
"cs add ./cscope.out
"endif

"etc
set title           "타이틀바에 현재 편집중인 파일을 표시
set nu
set novisualbell    "경고용 화면 깜빡임 끔
set nuw=4           "줄 번호 표시 너비 설정
set wmnu            "명령줄에 탭 완성시 자동완성 목록 보여줌
"set splitbelow     "화면 분할시 상[하] 우선
set splitright      "화면 분할시 좌[우] 우선   
set noet
"set et             "tab 대신 sts에 설정한 값만큼 스페이스 입력
"set sts=4          "et가 설정되어 있으면 tab 대신 지정한 수의 스페이스 입력
set ts=4            "직접 탭 입력 시 몇 개의 스페이스로 표시할지 설정. :retab을 입력하면 파일 내의 탭을 tabstop 만큼의 스페이스로 바꿔준다.
set sw=4            "들여쓰기 한 단계의 폭(칸 수)으로 탭을 몇 칸으로 표시할지 정함.
set smarttab        "sw, ts sts를 참조하여 탭과 백스페이스 키 동작 보조
set ai              "이전 줄의 들여쓰기를 유지
set si              "이전 줄 들여쓰기에 {, }, # 같은 패턴에 자동으로 한레벨 더 들여쓰기 내어쓰기 맨앞으가 적용
"set cindent
set nostartofline   "밑줄로 이동할 때 커서가 가장 왼쪽의 시작점으로 이동하지 못하게 한다
set laststatus=2    "하단 상태바출력(0: 표시X, 1: 창이 두개 이상일때 표시, 2: 항상표시)
set statusline=%<%f\ %h%m%r%=%{&fileencoding}\ %-14.(%l,%c%V%)\ %P
set hlsearch
"set incsearch      "찾는글자칠때마다 찾은글자표시
set ic              "대소문자 무시
set scs             "대문자로 입력하면 대문자 검색
set showmatch       "매칭되는 괄호보이기  
"set pt=<Ins>       "인서트키로 paste, nopate 상태전환
set nowrap          "자동줄바꿈X
set nowrapscan      "파일끝에 도달하면 찾지않음
"set ruler	        "커서 위치 정보 표시
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
nmap <F9> :call HexView()<CR>
nmap <F10> ma:%!git blame %<CR>`a
map <F11> :<C-u>call CopyHash()<CR> :vnew <C-r>".diff \| %!git show <C-r>"<CR>

"highlight DoubleClick
nmap <2-LeftMouse> *#  "highlight DoubleClick
nnoremap <leader>g :call GrepCurrentWord()<CR>

"블럭잡힌 각 라인에 // 주석추가
"vmap <C-J> :norm i//<CR>
"vmap <C-K> :norm 0xx<CR>

"현재 커서 위치를 보존하면서 문서내 윈도우 개행 제거
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/  "라인 마지막 공백 붉은색 표시


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

" 현재 단어를 grep -rn으로 검색 후 새 탭에 결과 보기
function! GrepCurrentWord()
    " 현재 커서가 위치한 단어 추출
    let l:word = expand("<cword>")

    " grep 명령 실행 (현재 디렉토리 기준)
    "let l:cmd = 'grep -rn --include="*.c" --include="*.h" --include="*.cpp" --include="*.py" --include="*.js" --include="*.ts" --include="*.java" --include="*.rb" --include="*.go" --include="*.php" --include="*.sh" "' . l:word . '" .'
    let l:cmd = 'grep -rn --include="*.c" --include="*.h" --include="*.cpp" --include="*.py" --include="*.js" --include="*.ts" --include="*.java" --include="*.rb" --include="*.go" --include="*.php" --include="*.sh" "' . l:word . '" .'

    " grep 결과를 새 탭에 분할 창으로 열기
    vnew
    silent execute 'r !' . l:cmd
    normal! gg
endfunction

" 현재 파일을 새창에 16진수로 로딩
function! HexView()
    " 현재 버퍼의 내용을 16진수로 변환
    let l:hex = system('xxd -g 1', join(getline(1, '$'), "\n") . "\n")

    " 새로운 수직 창 생성
    vertical new

    " Hex Dump 출력
    call setline(1, split(l:hex, "\n"))

    " 읽기 전용 임시 버퍼 설정
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nowrap
    setlocal nomodified
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
