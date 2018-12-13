:: Install madgui in development-mode
@call "%~dp0\lib\_setvars"

:: First download everything (can be used for offline installation later):
pip download -d "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\requirements.txt"
