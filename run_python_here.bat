@echo off
call %~dp0\util\setvars
python %*
if ERRORLEVEL 1 (
    pause
)
