@call "%~dp0\lib\_setvars"

pip install --target "%PY_LIB%" --find-links "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\requirements.txt"

pause
