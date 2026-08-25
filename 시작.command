#!/bin/bash
cd "$(dirname "$0")"

if ! command -v python3 &> /dev/null; then
    echo "오류: python3가 설치되지 않았습니다."
    echo "https://www.python.org 에서 설치 후 다시 실행해주세요."
    read -p "Enter를 누르면 닫힙니다..."
    exit 1
fi

python3 main.py
