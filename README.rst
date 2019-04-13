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

There is also a powershell script that does the same. It can be executed
using::

    powershell -ExecutionPolicy Bypass -File make.ps1

This works for a while to finally create a ``madgui_X.X.X_setup.exe`` that can
be used to install madgui on another machine.

After installation, copy runtime dependencies such as beamoptikdll into the
madgui folder.


Update madgui version
---------------------

The versions of madgui and its dependencies are configured in the
``requirements.txt`` file.


Future directions
-----------------

The current method extracts a standalone python installation along with madgui
and all dependencies in the target folder. The advantage of this method is
that it is probably the easiest to setup and does everything that we want:

- madgui python sources are installed as plain text. This is important to
  allow debugging and changing code! (**essential**)
- no package conflicts with other applications (**essential**)
- can coexist with other madgui installations
- no activation script required
- simple installer

Before migrating to another deployment method, make sure that at least the
first three of the above properties remain intact! A counter-example would be
installing madgui directly as site-package of one of the python distributions
shared with other applications.

Potential alternative solutions to create a deployable madgui installation:

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
