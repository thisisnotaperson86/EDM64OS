@echo off
if "%~1"=="" (
  echo Uso: resize-boxart.cmd C:\CARPETA_DE_ENTRADA
  pause
  exit /b 1
)
cd /d "%~dp0.."
py -m pip install -r tools\requirements.txt
py tools\resize_boxart.py "%~1" "boxart-output\menu" --size 92x65
py tools\resize_boxart.py "%~1" "boxart-output\lowres" --size 158x112
if errorlevel 1 (
  echo ERROR DE CONVERSION.
  pause
  exit /b 1
)
echo LISTO: boxart-output\menu y boxart-output\lowres
pause
