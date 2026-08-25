@echo off
cd /d "%~dp0"

echo =============================================
echo   Build: RFP Analyzer
echo =============================================
echo.

:: py launcher (recommended) -> python 순으로 시도
set PYTHON_CMD=
where py > nul 2>&1
if not errorlevel 1 (
    set PYTHON_CMD=py
    goto :found
)
where python > nul 2>&1
if not errorlevel 1 (
    set PYTHON_CMD=python
    goto :found
)

echo [ERROR] Python not found.
echo Install from https://www.python.org ^(Add to PATH 체크^) and retry.
pause
exit /b 1

:found
echo Python command: %PYTHON_CMD%
echo.

echo [1/2] Installing dependencies...
%PYTHON_CMD% -m pip install --upgrade pip
%PYTHON_CMD% -m pip install pyinstaller pywebview fastapi "uvicorn[standard]" httpx openpyxl
if errorlevel 1 (
    echo [ERROR] pip install failed.
    pause
    exit /b 1
)

echo.
echo [2/2] Building (may take a few minutes)...
%PYTHON_CMD% -m PyInstaller --noconfirm build_win.spec
if errorlevel 1 (
    echo [ERROR] PyInstaller failed.
    pause
    exit /b 1
)

echo.
echo =============================================
echo   Done! Run dist\RFP-Analyzer\RFP-Analyzer.exe
echo =============================================
pause
