:: Install MadQt in development-mode
@echo off
call %~dp0\setvars

:: Install common python packages
pip install --target %MADQT_PYTHON_PACKAGES% --ignore-installed \
    -r %MADQT_ROOT%\util\requirements_common.txt

:: Install "easy" dependencies
pip install --target %MADQT_PYTHON_PACKAGES%

call %MADQT_ROOT%\tools\build_cpymad_inplace.bat
call %MADQT_ROOT%\tools\generate_egg_info.bat

cd %MADQT_ROOT%\src\cpymad
python setup.py build_ext --libmadx

pip install --src %MADQT_ROOT%\src \

cd dev
