@echo off
call %~dp0\util\setvars
python -m hit_csys.gui_qt %*
if ERRORLEVEL 1 (
    pause
)
