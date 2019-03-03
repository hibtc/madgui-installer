@call "%~dp0\activate.bat"

pip install -t "%~dp0\site-packages" ^
    -f "%~dp0\wheels" --no-index ^
    -r "%~dp0\requirements.txt"

pause
