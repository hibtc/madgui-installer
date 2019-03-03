@call "%~dp0\activate.bat"

pip install -t "%PY_LIB%" ^
    -f "%PY_PIP%" --no-index ^
    -r "%MADGUI_ROOT%\requirements.txt"

pause
