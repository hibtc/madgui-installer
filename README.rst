madqt-portable
==============

Folder structure and scripts for getting a portable development version of
madqt_ for windows.

.. _madqt: https://github.com/hibtc/madqt


Folders
-------

::

    bin                         Binaries installed by python packages
    cache                       Downloaded installers for python packages
    lib                         Statically installed python packages
    python                      Python distributions (Extract WinPython here)
    runtime                     Runtime libraries (Put BeamOptikDLL.dll here)
    src                         Sources for our python packages
    util                        Install scripts and utilities


Installation
------------

Static installation
~~~~~~~~~~~~~~~~~~~

- Obtain the folder structure and utility scripts::

    git clone https://github.com/hibtc/madqt-portable

- Install `WinPython 3.4 Qt5`_ in its own folder under ``python/``, e.g.
  ``python/WinPython-64bit-3.4.4.4Qt5``.

- Copy runtime dependencies into ``runtime/`` (beamoptikdll).

- Download and install packages::

    util\install_static.bat

- Good luck!


Development version
~~~~~~~~~~~~~~~~~~~

- In *git bash*::

    git clone https://github.com/hibtc/madqt-portable && cd madqt-portable
    git submodule update --init -j 2

- Install `WinPython 3.4 Qt5`_ in its own folder under ``python/``, e.g.
  ``python/WinPython-64bit-3.4.4.4Qt5``.

- Copy runtime dependencies into ``runtime/`` (beamoptikdll).

- Download and install *easy* packages::

    util\install_devel.bat

- You *can* use a prebuilt version of cpymad_ (much faster but not installed
  in development mode)::

    util\download_cpymad.bat

- Otherwise, first install a recent version of cmake_ and then build and
  install cpymad as follows::

    git clone https://github.com/MethodicalAcceleratorDesign/MAD-X src/MAD-X -b 5.03.07

    util\build_madx.bat
    util\build_cpymad.bat

.. _WinPython 3.4 Qt5: https://winpython.github.io/
.. _cpymad: https://pypi.python.org/pypi/cpymad/
.. _cmake: https://cmake.org/


Usage
-----

Double-click on ``run_madqt.bat``.


Troubleshooting
---------------

- Python 3.5 is not yet supported for `technical reasons`_.

- If you use anything else but WinPython 3.4, you have to modify
  ``setvars.bat`` accordingly (or you may put values into ``env.bat``)!

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
