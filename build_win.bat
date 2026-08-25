@echo off
chcp 65001 > nul
cd /d "%~dp0"

echo 의존성 설치 중...
pip install pyinstaller pywebview fastapi "uvicorn[standard]" httpx openpyxl

echo 빌드 중...
pyinstaller ^
  --windowed ^
  --name "제안요청서분석기" ^
  --add-data "부록설계_양식.xlsx;." ^
  --add-data "index.html;." ^
  --hidden-import "uvicorn.logging" ^
  --hidden-import "uvicorn.loops" ^
  --hidden-import "uvicorn.loops.auto" ^
  --hidden-import "uvicorn.protocols" ^
  --hidden-import "uvicorn.protocols.http" ^
  --hidden-import "uvicorn.protocols.http.auto" ^
  --hidden-import "uvicorn.protocols.websockets" ^
  --hidden-import "uvicorn.protocols.websockets.auto" ^
  --hidden-import "uvicorn.lifespan" ^
  --hidden-import "uvicorn.lifespan.on" ^
  --hidden-import "webview.platforms.edgechromium" ^
  main.py

echo.
echo 빌드 완료!
echo dist\제안요청서분석기.exe 파일을 배포하세요.
pause
