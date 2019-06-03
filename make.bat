:: Install py37 for site-packages:

call md pkg
call cl                         ^
    python.c                            ^
    /link /out:pkg\python.exe                                   || goto :error

@exit /b 0


:error
@set errcode=%ERRORLEVEL%
@echo "Previous command returned error code: %errcode%"
@exit /b %errcode%
