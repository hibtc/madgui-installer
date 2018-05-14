@call "%~dp0\_setvars"
python -m hit_csys.gui_qt %*
if ERRORLEVEL 1 (
    pause
)
