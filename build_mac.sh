#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "의존성 설치 중..."
pip3 install pyinstaller pywebview fastapi "uvicorn[standard]" httpx openpyxl

echo "빌드 중..."
pyinstaller --noconfirm build_mac.spec

echo ""
echo "빌드 완료!"
echo "dist/RFP-Analyzer.app 을 Applications 폴더로 옮겨서 사용하세요."
