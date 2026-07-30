@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0verify-repository.ps1"
if errorlevel 1 (
  echo ERROR DE VERIFICACION.
  pause
  exit /b 1
)
pause
