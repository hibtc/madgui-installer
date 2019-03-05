madgui-installer
================

Scripts for creating a madgui_ installer on windows.

.. _madgui: https://github.com/hibtc/madgui


Usage
-----

Install miniconda_ (or anaconda) and open a conda terminal. Navigate to this
folder and execute::

    make

.. _miniconda: https://docs.conda.io/en/latest/miniconda.html

This works for a while to finally create a ``madgui_X.X.X_setup.exe`` that can
be used to install madgui on another machine.

The installer allows to either install a small python distribution alongside
madgui (recommended), or choose an existing python 3.7 installation on the
host.

Next, copy runtime dependencies such as beamoptikdll into the madgui folder.


Future directions
-----------------

The installer currently creates something akin a *poor man's* virtual
environment on the target system. It is probably better to use an existing
solution instead. Possible candidates are

- venv_ (stdlib)
- pyqtdeploy_ (cross-platform)
- PyInstaller_ (cross-platform)
- cx_Freeze_ (cross-platform)
- nuitka_ (cross-platform)
- py2exe_ (windows)
- py2app_ (Mac OS X)

.. _venv: https://docs.python.org/3/library/venv.html
.. _pyqtdeploy: http://pyqt.sourceforge.net/Docs/pyqtdeploy/
.. _PyInstaller: http://www.pyinstaller.org/
.. _cx_Freeze: http://cx-freeze.sourceforge.net/
.. _py2exe: http://www.py2exe.org/
.. _py2app: http://pythonhosted.org/py2app/
.. _nuitka: http://nuitka.net

If you succeed in using one of those tools, you are welcome to contribute a
short guide here.
