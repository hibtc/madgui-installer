:: Install py34 for mingwpy:
call conda create -p py34 -qy python=3.4                        || goto :error
call conda activate .\py34                                      || goto :error
call conda install -qy mingwpy -c conda-forge                   || goto :error
call conda install -qy 7za pywget                               || goto :error

:: Download embeddable python:
set "DIR=python-3.7.2.post1-embed-amd64"
set "URL=https://www.python.org/ftp/python/3.7.2/%DIR%.zip"
call python -m wget "%URL%" -o "%DIR%.zip"                      || goto :error
call 7za x -y "-o%DIR%" "%DIR%.zip"                             || goto :error

:: Install py37 for site-packages:
call conda create -p py37 -qy python=3.7 wheel                  || goto :error
call conda activate .\py37                                      || goto :error
call conda install -qy nsis -c nsis                             || goto :error
call pip wheel -w wheelhouse -r requirements.txt                || goto :error
call pip install -t site-packages -r requirements.txt ^
    -f wheelhouse --no-index                                    || goto :error

set "gcc=py34\Scripts\gcc.exe"
set "windres=py34\Scripts\windres.exe"
set "cflags=-Ipy37\include"
set "lflags=-Lpy37\libs -lpython37"

call %gcc% %cflags% python.c %lflags% -o python.exe             || goto :error

call %windres% madgui.rc -O coff -o madgui.res                  || goto :error
call %gcc% %cflags% launcher.c %lflags% ^
    -o madgui.exe -DMODULE=madgui madgui.res                    || goto :error
call %gcc% %cflags% launcher.c %lflags% ^
    -o beamopt.exe -DMODULE=hit_acs.gui_qt                      || goto :error

call makensis madgui.nsi                                        || goto :error
@exit /b 0

:error
@set errcode=%ERRORLEVEL%
@echo "Previous command returned error code: %errcode%"
@exit /b %errcode%
