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

python main.py
