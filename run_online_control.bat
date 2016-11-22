@echo off
call %~dp0\scripts\setvars
python -m hit.online_control.qt %*
if ERRORLEVEL 1 (
    pause
)
