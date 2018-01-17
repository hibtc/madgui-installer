:: Find and activate a WinPython distribution installed in this folder.
:: Before calling, you must first set PY_ARCH and PY_VER

set PY_ROOT=%~dp0
for /f "tokens=*" %%A in ('dir /b /a:d /o:n "%PY_ROOT%\WinPython-%PY_ARCH%bit-%PY_VER%.*"') do (
    set PY_DIR=%PY_ROOT%\%%A
)

call "%PY_DIR%\scripts\env.bat"
