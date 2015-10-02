@echo off
call setvars
python -m madgui
if ERRORLEVEL 1 (
    pause
)