@call "%~dp0\_setvars"
python -m madgui %*
if ERRORLEVEL 1 (
    pause
)
