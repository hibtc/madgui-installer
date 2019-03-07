:: Install py34 for mingwpy:
call conda create -p py34 -qy python=3.4
call conda activate .\py34
call conda install -qy mingwpy -c conda-forge
call conda install -qy 7za pywget

:: Download embeddable python:
set "DIR=python-3.7.2.post1-embed-amd64"
set "URL=https://www.python.org/ftp/python/3.7.2/%DIR%.zip"
call python -m wget "%URL%" -o "%DIR%.zip"
call 7za x -y "-o%DIR%" "%DIR%.zip"

:: Install py37 for site-packages:
call conda create -p py37 -qy python=3.7 wheel
call conda activate .\py37
call conda install -qy nsis -c nsis
call pip wheel -w wheelhouse -r requirements.txt
call pip install -t site-packages -r requirements.txt ^
    -f wheelhouse --no-index

set "gcc=py34\Scripts\gcc.exe"
set "windres=py34\Scripts\windres.exe"
set "cflags=-Ipy37\include"
set "lflags=-Lpy37\libs -lpython37"

call %gcc% %cflags% python.c %lflags% -o python.exe

call %windres% madgui.rc -O coff -o madgui.res
call %gcc% %cflags% launcher.c %lflags% -o madgui.exe -DMODULE=madgui madgui.res
call %gcc% %cflags% launcher.c %lflags% -o beamopt.exe -DMODULE=hit_acs.gui_qt

call makensis madgui.nsi
