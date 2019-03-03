@call "%~dp0\activate.bat"

pip install --target "%PY_LIB%" --find-links "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\requirements.txt"

pause
