:: Find and activate a WinPython distribution installed in this folder.
:: Before calling, you must first set MADQT_ARCH and MADQT_PYTHON_VERSION

for /f "tokens=*" %%A in ('dir /b "%~dp0\WinPython-%MADQT_ARCH%bit-%MADQT_PYTHON_VERSION%.*"') do (
    set MADQT_PYTHON_FOLDER=%~dp0\%%A
)

call %MADQT_PYTHON_FOLDER%\scripts\env.bat
