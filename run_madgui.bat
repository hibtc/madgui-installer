@echo off
call "%~dp0\util\setvars"
python -m madgui %*
if ERRORLEVEL 1 (
    pause
)
