madgui-portable
===============

Folder structure and scripts for deploying a portable development version of
madgui_ for windows.

.. _madgui: https://github.com/hibtc/madgui


Folders
-------

::

    lib                         Statically installed python packages
    src                         Sources for our python packages


Installation
------------

- In *git bash*::

    git clone https://github.com/hibtc/madgui-portable && cd madgui-portable
    git submodule update --init -j 2

- Install python3 (e.g. `WinPython 3.4 Qt5`_) alongside/into madgui folder

- Copy runtime dependencies such as beamoptikdll alongside/into madgui folder

- Add an ``env.bat`` file in the root folder that activates the python
  environment, and add beamoptikdll to PATH, e.g.::

    call "%~dp0..\WinPython-64bit-3.4.4.4Qt5\scripts\env.bat"
    set "PATH=%~dp0..\beamoptikdll;%PATH%"

- Download packages for later installation::

    setup_download.bat

- Install packages (can be done offline)::

    setup_install.bat

.. _WinPython 3.4 Qt5: https://winpython.github.io/


Usage
-----

Double-click on ``run_madgui.bat``.


Alternatives
------------

It may be more reliable and require less manual labour to use one of the
following tools to craft a portable application:

- PyInstaller_ (cross-platform)
- cx_Freeze_ (cross-platform)
- nuitka_ (cross-platform)
- py2exe_ (windows)
- py2app_ (Mac OS X)

.. _PyInstaller: http://www.pyinstaller.org/
.. _cx_Freeze: http://cx-freeze.sourceforge.net/
.. _py2exe: http://www.py2exe.org/
.. _py2app: http://pythonhosted.org/py2app/
.. _nuitka: http://nuitka.net

If you succeed in using one of those tools, you are welcome to contribute a
short guide here.
