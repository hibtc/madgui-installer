:: Install py34 for mingwpy:
call conda create -n py34_build -qyf python=3.4
call conda activate py34_build
call conda install -qyf mingwpy -c conda-forge
for /f %%G in ('python -c "import sys; print(sys.prefix)"') do (
    set "gcc=%%~fG\Scripts\gcc.exe"
)

:: Install py37 for site-packages:
call conda create -n py37_build -qyf python=3.7 wheel nsis
call conda activate py37_build
call pip wheel -w "%~dp0\wheelhouse" -r "%~dp0\requirements.txt"
call pip install -t "%~dp0\site-packages" -r "%~dp0\requirements.txt" ^
    -f "%~dp0\wheelhouse" --no-index

for /f %%G in ('python -c "import sys; print(sys.prefix)"') do (
    set "pythondir=%%~fG"
)

call %gcc% -o python.exe ^
    python.c ^
    -I%pythondir%\include ^
    -L%pythondir%\libs ^
    -lpython37

call makensis madgui.nsi
