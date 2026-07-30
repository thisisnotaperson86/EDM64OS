@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0update-manifest.ps1"
if errorlevel 1 (
  echo ERROR AL ACTUALIZAR EL MANIFIESTO.
  pause
  exit /b 1
)
pause
