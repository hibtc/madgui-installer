madgui-portable
===============

Folder structure and scripts for deploying a portable development version of
madgui_ for windows.

.. _madgui: https://github.com/hibtc/madgui


Installation
------------

- In *git bash*::

    git clone https://github.com/hibtc/madgui-portable
    cd madgui-portable
    git clone https://github.com/hibtc/hit_models

- Install python 3.7 (or later) alongside/into madgui folder

- Activate a build environment with mingw and type::

    make

- Copy runtime dependencies such as beamoptikdll alongside/into madgui folder

- Modify ``activate.bat`` file in the root folder for the correct python and
  beamoptikdll pathes.

- Download packages for later installation::

    setup_download.bat

- Install packages (can be done offline)::

    setup_install.bat


Usage
-----

Double-click on ``run_madgui.bat``.


Alternatives
------------

It may be more reliable and require less manual labour to use one of the
following tools to craft a portable application:

- pyqtdeploy_ (cross-platform)
- PyInstaller_ (cross-platform)
- cx_Freeze_ (cross-platform)
- nuitka_ (cross-platform)
- py2exe_ (windows)
- py2app_ (Mac OS X)

.. _pyqtdeploy: http://pyqt.sourceforge.net/Docs/pyqtdeploy/
.. _PyInstaller: http://www.pyinstaller.org/
.. _cx_Freeze: http://cx-freeze.sourceforge.net/
.. _py2exe: http://www.py2exe.org/
.. _py2app: http://pythonhosted.org/py2app/
.. _nuitka: http://nuitka.net

If you succeed in using one of those tools, you are welcome to contribute a
short guide here.
