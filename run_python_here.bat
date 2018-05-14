@call "%~dp0\_setvars"
python %*
if ERRORLEVEL 1 (
    pause
)
