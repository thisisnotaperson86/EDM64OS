@echo off
cd /d "%~dp0.."
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0create-full-source.ps1"
if errorlevel 1 (
  echo ERROR DE EXPORTACION.
  pause
  exit /b 1
)
pause
