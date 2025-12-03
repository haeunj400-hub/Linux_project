#!/bin/bash

TARGET_DIR="$1" #첫번째 인자로 전달된 대상 폴더 경로를 변수에 저장

#폴더 경로를 입력하지 않은 경우
if [ -z "$TARGET_DIR" ]; then
    echo -n "정리할 폴더 경로를 입력하세요."
    read TARGET_DIR
    
    #사용자 입력후에도 경로가 여전히 비어 있다면 종료
    if [ -z "$TARGET_DIR" ]; then
        echo "경로가 입력되지 않아 종료합니다."
        exit 1
    fi
fi

#입력받은 대상 폴더로 이동, 실패 시 종료
cd "$TARGET_DIR" || { echo "해당 폴더로 이동할 수 없습니다. 경로: $TARGET_DIR"; exit 1; }

#현재 폴더의 모든 파일을 대상으로 반복 수행
for file in *; do
    if [ -f "$file" ]; then
        ext="${file##*.}" #파일 확장자 추출

        #확장자에 따라 정리될 대상 폴더 결정
        case "$ext" in
            jpg|jpeg|png|gif) folder="이미지" ;;     #이미지파일
            txt|pdf|doc|docx|md) folder="문서" ;;   #문서파일
            sh|c|cpp|py|java) folder="코드" ;;      #코드파일
            zip|tar|gz|7z) folder="압축" ;;         #압축파일
            *) folder="etc" ;;                     #기타파일
        esac

        mkdir -p "$folder"          #폴더가 없으면 생성
        mv "$file" "$folder/"       #해당 폴더로 파일 이동
        echo "$file -> $folder/"    #정리 결과 출력
    fi
done