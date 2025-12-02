#!/bin/bash

# ==========================================
# 1. 환경변수 설정 (Configuration)
# ==========================================
export TARGET_DIR="./files"     # 정리할 대상 폴더
export BACKUP_DIR="./backup"    # 백업 파일이 저장될 폴더

# 폴더가 없으면 생성 > 에러 방지
mkdir -p "$TARGET_DIR"
mkdir -p "$BACKUP_DIR"

# 기능 3: 압축 백업 (tar 명령어 활용)
function func_backup() {
    echo "전체 파일을 압축하여 백업합니다."
    
    # 시간 정보를 파일명에 포함
    DATE_TIME=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILENAME="backup_$DATE_TIME.tar.gz"
    
    # tar -czf [대상 파일명] [압축할 폴더]
    tar -czf "$BACKUP_DIR/$BACKUP_FILENAME" "$TARGET_DIR" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "백업 성공: $BACKUP_DIR/$BACKUP_FILENAME"
    else
        echo "백업 실패: $TARGET_DIR 경로를 확인하세요."
    fi
}

# 기능 4: 파일 검색 (find 명령어 활용)
function func_search() {
    echo -n "검색할 파일 이름을 입력하세요: "
    read KEYWORD
    
    if [ -z "$KEYWORD" ]; then
        echo "검색어를 입력해주세요."
        return
    fi

    echo "--- '$KEYWORD' 검색 결과 ---"
    # find [디렉토리] -name 
    find "$TARGET_DIR" -name "*$KEYWORD*"
    echo "----------------------------"
}

# ==========================================
#  4. 메인 메뉴 구성 
# ==========================================
while true; do
    echo ""
    echo "====== [리눅스 파일 매니저] ======"
    echo "1. 파일 자동 정리 (B)"
    echo "2. 오래된 로그 삭제 (B)"
    echo "3. 전체 압축 백업 (A)"
    echo "4. 파일 검색 (A)"
    echo "0. 종료"
    echo "================================"
    echo -n "명령을 선택하세요: "
    read CHOICE

    case $CHOICE in
        1) ./sort_files.sh ;;  
        2) ./clean_files.sh ;;     
        3) func_backup ;;    
        4) func_search ;;    
        0) echo "프로그램을 종료합니다."; break ;;
        *) echo "잘못된 입력입니다." ;;
    esac
done