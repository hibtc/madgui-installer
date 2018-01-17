:: Build cpymad C-extension in the local src folder.
@setlocal
@echo off
call "%~dp0\setvars"

cd "%PY_SRC%\cpymad"

call python setup.py build_ext --madxdir="%MADX_BIN%"
call python setup.py develop --install-dir="%PY_LIB%"

pause
endlocal
