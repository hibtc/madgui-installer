@echo off
call %~dp0\scripts\setvars
python %*
if ERRORLEVEL 1 (
    pause
)
