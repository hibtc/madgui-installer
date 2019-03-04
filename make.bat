:: Install py34 for mingwpy:
call conda create -p py34 -qyf python=3.4
call conda activate .\py34
call conda install -qyf mingwpy -c conda-forge

:: Install py37 for site-packages:
call conda create -p py37 -qyf python=3.7 wheel
call conda activate .\py37
call conda install -qyf nsis -c nsis
call pip wheel -w "%~dp0\wheelhouse" -r "%~dp0\requirements.txt"
call pip install -t "%~dp0\site-packages" -r "%~dp0\requirements.txt" ^
    -f "%~dp0\wheelhouse" --no-index

set "gcc=py34\Scripts\gcc.exe"
set "pythondir=py37"
call %gcc% -o python.exe ^
    python.c ^
    -I%pythondir%\include ^
    -L%pythondir%\libs ^
    -lpython37

call makensis madgui.nsi
