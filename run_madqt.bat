@echo off
call %~dp0\util\setvars
python -m madqt %*
if ERRORLEVEL 1 (
    pause
)
