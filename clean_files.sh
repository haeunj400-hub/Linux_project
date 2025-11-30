#!/bin/bash

TARGET_DIR="$1" #첫번째 인자로 전달된 폴더 경로 저장

#폴더 경로를 입력하지 않은 경우
if [ -z "$TARGET_DIR" ]; then
    echo "정리할 폴더 경로를 입력하세요."
    exit 1
fi

#입력받은 대상 폴더로 이동, 실패 시 종료
cd "$TARGET_DIR" || { echo "해당 폴더로 이동할 수 없습니다."; exit 1; }

#청소 작업 안내
echo "'$TARGET_DIR' 폴더에서 7일 이상 지난 파일을 찾는 중입니다."

#find로 파일 목록 수집
OLD_FILES=$(find . -type f -mtime +7)

#아무 파일도 없으면 종료
if [ -z "$OLD_FILES" ]; then
    echo "7일 이상 지난 파일이 없습니다. 삭제할 파일이 없습니다."
    exit 0
fi

echo "다음 파일들이 7일 이상 지난 파일로 확인되었습니다: "
echo "$OLD_FILES"
echo

#사용자에게 삭제 여부 확인
read -p "정말 삭제하시겠습니까? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "삭제 작업이 취소되었습니다."
    exit 0
fi

echo "삭제 작업을 진행합니다.."

#실제 파일 삭제
echo "$OLD_FILES" | while read -r file; do
    rm -f "$file"
    echo "삭제됨: $file"
done

echo "정리 완료되었습니다."