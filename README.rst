madgui-portable
===============

Folder structure and scripts for getting a portable development version of
madgui_ for windows.

.. _madgui: https://github.com/hibtc/madgui


Folders
-------

::

    bin                         Runtime libraries (Put BeamOptikDLL.dll here)
    lib                         Statically installed python packages
    src                         Sources for our python packages


Installation
------------

- In *git bash*::

    git clone https://github.com/hibtc/madgui-portable && cd madgui-portable
    git submodule update --init -j 2

- Install `WinPython 3.4 Qt5`_ alongside madgui or in ``bin/``

- Copy runtime dependencies into ``bin/`` (beamoptikdll).

- Add ``env.bat`` file that is responsible to activate the python environment,
  e.g.::

    call "%~dp0..\WinPython-64bit-3.4.4.4Qt5\scripts\env.bat"

- Download and install packages::

    setup.bat

.. _WinPython 3.4 Qt5: https://winpython.github.io/


Usage
-----

Double-click on ``run_madgui.bat``.


Troubleshooting
---------------

- Python 3.5 is not yet supported for `technical reasons`_.

- If you use anything else but WinPython 3.4, you have to modify
  ``_setvars.bat`` accordingly (or you may put values into ``env.bat``)!

- Make sure to use the *Qt* not the *zero* versions of WinPython

- In case of problems with cpymad, refer to the `cpymad installation
  instructions`_.

.. _technical reasons: https://github.com/hibtc/cpymad/issues/32
.. _cpymad installation instructions: http://hibtc.github.io/cpymad/installation/windows.html


Alternatives
------------

It may be more reliable and require less manual labour to use one of the
following tools to craft a portable application:

- PyInstaller_ (cross-platform)
- cx_Freeze_ (cross-platform)
- py2exe_ (windows)
- py2app_ (Mac OS X)

.. _PyInstaller: http://www.pyinstaller.org/
.. _cx_Freeze: http://cx-freeze.sourceforge.net/
.. _py2exe: http://www.py2exe.org/
.. _py2app: http://pythonhosted.org/py2app/

If you succeed in using one of those tools, you are welcome to contribute a
short guide here.
