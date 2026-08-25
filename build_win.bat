@echo off
chcp 65001 > nul
cd /d "%~dp0"

echo =============================================
echo   제안요청서분석기 Windows 빌드
echo =============================================
echo.

where python > nul 2>&1
if errorlevel 1 (
    echo [오류] Python이 설치되지 않았습니다.
    echo https://www.python.org 에서 설치 후 다시 실행해주세요.
    pause
    exit /b 1
)

echo [1/2] 의존성 설치 중...
python -m pip install pyinstaller pywebview fastapi "uvicorn[standard]" httpx openpyxl
if errorlevel 1 (
    echo [오류] 의존성 설치 실패. 위 오류 메시지를 확인하세요.
    pause
    exit /b 1
)

echo.
echo [2/2] 빌드 중 (수 분 소요)...
python -m PyInstaller --noconfirm build_win.spec
if errorlevel 1 (
    echo.
    echo [오류] 빌드 실패. 위 오류 메시지를 확인하세요.
    pause
    exit /b 1
)

echo.
echo =============================================
echo   빌드 완료!
echo   dist\제안요청서분석기 폴더 안의 exe를 실행하세요.
echo =============================================
pause
