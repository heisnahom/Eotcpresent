@echo off
:: Check for admin privileges, relaunch elevated if not admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
echo ============================================================
echo EOTC Present - Easy Installer
echo ============================================================
echo.

echo 1. Downloading security certificate...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://heisnahom.github.io/Eotcpresent/eotc_present.cer' -OutFile 'eotc_present.cer'"

echo 2. Installing certificate to Trusted Root Certification Authorities...
certutil -addstore -f "Root" "eotc_present.cer"

echo 3. Downloading App Installer...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://heisnahom.github.io/Eotcpresent/eotc_present.appinstaller' -OutFile 'eotc_present.appinstaller'"

echo 4. Opening installer window...
start eotc_present.appinstaller

echo Done! The app installer window should open now.
timeout /t 5
