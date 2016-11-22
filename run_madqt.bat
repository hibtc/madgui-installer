@echo off
call %~dp0\scripts\setvars
python -m madqt %*
if ERRORLEVEL 1 (
    pause
)
