@echo off
chcp 65001 > nul
cd /d "%~dp0"

where python > nul 2>&1
if errorlevel 1 (
    echo 오류: Python이 설치되지 않았습니다.
    echo https://www.python.org 에서 설치 후 다시 실행해주세요.
    pause
    exit /b 1
)

if not exist ".deps_installed" (
    echo 필요한 패키지를 설치 중입니다...
    pip install -r requirements.txt -q
    if errorlevel 1 (
        echo 패키지 설치 실패. 인터넷 연결을 확인하거나 관리자 권한으로 실행해주세요.
        pause
        exit /b 1
    )
    echo. > .deps_installed
    echo 설치 완료.
)

python main.py
