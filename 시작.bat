@echo off
cd /d "%~dp0"

where python > nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing Python via winget...
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
        echo [ERROR] Please close this window and run again.
        pause
        exit /b 1
    )
)

python -c "import fastapi, uvicorn, httpx, openpyxl, webview" > nul 2>&1
if errorlevel 1 (
    echo [INFO] Installing packages...
    python -m pip install --upgrade pip --quiet
    python -m pip install -r requirements.txt --quiet
    if errorlevel 1 (
        echo [ERROR] Package installation failed.
        echo Run as administrator or check internet connection.
        pause
        exit /b 1
    )
    echo [INFO] Done.
)

python main.py
if errorlevel 1 (
    echo [ERROR] App failed to start.
    pause
)
