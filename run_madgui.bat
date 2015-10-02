@echo off
call scripts\_setvars
python -m madgui
if ERRORLEVEL 1 (
    pause
)
