@call "%~dp0\_setvars"

:: Download everything (can be used for offline installation later):
pip download -d "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\requirements.txt"