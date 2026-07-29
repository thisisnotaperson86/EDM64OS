@echo off
cd /d "%~dp0.."
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-sd.ps1" -DriveLetter D
if errorlevel 1 (
  echo ERROR REAL DE INSTALACION.
  pause
  exit /b 1
)
pause
