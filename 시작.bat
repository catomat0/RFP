@echo off
chcp 65001 > nul
cd /d "%~dp0"

:: 1. Python 확인 및 자동 설치
where python > nul 2>&1
if errorlevel 1 (
    echo [INFO] Python not found. Installing via winget...
    winget install --id Python.Python.3.11 --source winget --silent --accept-package-agreements --accept-source-agreements
    if errorlevel 1 (
        echo [ERROR] Python installation failed.
        echo Please install manually from https://www.python.org
        pause
        exit /b 1
    )
    set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"
    where python > nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Python installed but PATH not updated.
        echo Please close this window and run the script again.
        pause
        exit /b 1
    )
    echo [INFO] Python installed successfully.
)

:: 2. 사용할 Python 경로 확정
for /f "delims=" %%i in ('where python') do set PYTHON=%%i & goto :found_python
:found_python

:: 3. 필요한 모듈 import 검사 후 없으면 설치
"%PYTHON%" -c "import fastapi, uvicorn, httpx, openpyxl, webview" > nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing required packages...
    "%PYTHON%" -m pip install -r requirements.txt -q
    if errorlevel 1 (
        echo [ERROR] Package installation failed.
        echo Please check your internet connection or run as administrator.
        pause
        exit /b 1
    )
    echo [INFO] Installation complete.
)

:: 4. 앱 실행
"%PYTHON%" main.py
if errorlevel 1 (
    echo.
    echo [ERROR] Application failed to start.
    pause
)
