:: Install py37 for site-packages:
call conda create -p py37 -qy python=3.7 wheel                  || goto :error
call conda activate .\py37                                      || goto :error
call conda install -qy nsis -c nsis                             || goto :error
call conda install -qy 7za pywget                               || goto :error

:: Download embeddable python:
set "ZIP=python-3.7.2.post1-embed-amd64.zip"
set "URL=https://www.python.org/ftp/python/3.7.2/%ZIP%"
call python -m wget "%URL%" -o "%ZIP%"                          || goto :error
call 7za x -y -opkg "%ZIP%"                                     || goto :error
:: DO NOT add quotes or space around `import site`, it will mess up the output!
echo import site>>pkg\python37._pth

call pip wheel -w wheels -r requirements.txt                    || goto :error
call pip install -f wheels -r requirements.txt ^
    -t pkg\Lib\site-packages --no-index -I                      || goto :error
call rd /s /q pkg\Lib\site-packages\bin

:: Safe our packages at top level to make them easier to find and edit,
:: and to prevent them from being minified down below:
call move pkg\Lib\site-packages\madgui pkg\
call move pkg\Lib\site-packages\minrpc pkg\
call move pkg\Lib\site-packages\cpymad pkg\
call move pkg\Lib\site-packages\hit_acs pkg\

:: Remove .py files in thirdparty packages:
call python minify.py pkg\Lib\site-packages                     || goto :error
:: Zip up pure packages for performance::
call python purelib.py pkg\Lib\site-packages                    || goto :error
call move purelib.zip pkg

:: Install py34 for mingwpy:
call conda create -p py34 -qy python=3.4                        || goto :error
call conda install -p py34 -qy mingwpy -c conda-forge           || goto :error

set "gcc=py34\Scripts\gcc.exe"
set "windres=py34\Scripts\windres.exe"
set "cflags=-Ipy37\include"
set "lflags=-Lpy37\libs -lpython37 -nostdlib -lkernel32 -lshell32"

:: Determine madgui version, and create madgui.rc:
for /f %%G in ('pkg\python -c "import madgui; print(madgui.__version__)"') do (set "VERSION=%%G")
call pip install j2cli
call j2 madgui.template.rc > madgui.rc

call %gcc% %cflags% python.c %lflags% -o pkg\python.exe         || goto :error

call %windres% madgui.rc -O coff -o madgui.res                  || goto :error
call %gcc% %cflags% launcher.c %lflags% -o pkg\madgui.exe ^
    -DMODULE=madgui madgui.res -mwindows                        || goto :error
call %gcc% %cflags% launcher.c %lflags% -o pkg\beamopt.exe ^
    -DMODULE=hit_acs.gui_qt                                     || goto :error

copy madgui.yml pkg                                             || goto :error
call makensis /DVERSION=%VERSION% madgui.nsi                    || goto :error
@exit /b 0

:error
@set errcode=%ERRORLEVEL%
@echo "Previous command returned error code: %errcode%"
@exit /b %errcode%
