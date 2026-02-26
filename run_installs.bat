@echo off
setlocal

>nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system"
if ERRORLEVEL 1 (
  echo Solicitando elevacao...
  powershell.exe -NoProfile -ExecutionPolicy Bypass ^
    -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AutoInstalls.ps1"

pause
