@call "%~dp0\activate.bat"

:: Download everything (can be used for offline installation later):
pip wheel -w "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\requirements.txt"
