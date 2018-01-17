madqt-portable
==============

Folder structure and scripts for getting a portable development version of
madqt_ for windows.

.. _madqt: https://github.com/hibtc/madqt


Folders
-------

::

    bin                         Binaries installed by python packages
    lib                         Statically installed python packages
    python                      Python distributions (Extract WinPython here)
    runtime                     Runtime libraries (Put BeamOptikDLL.dll here)
    src                         Sources for our python packages
    util                        Install scripts and utilities


Installation
------------

In order to obtain the sources, open a *git bash* somewhere and execute::

    git clone https://github.com/hibtc/madqt-portable

If you are going to setup a *development version*, retrieve the git
repositories of the packages that are maintained by us as follows::

    git submodule update --init -j 2

Furthermore, if you want to build and install MAD-X later on, download MAD-X
and checkout the required version now::

    git clone https://github.com/MethodicalAcceleratorDesign/MAD-X src/MAD-X -b 5.03.07

You can now close the git command shell.


python
~~~~~~

Now, please install `WinPython 3.4 Qt5`_ (do not use the *zero* versions!) in
its own folder under ``python/``. The installation directory should look
something like ``python/WinPython-64bit-3.4.4.4Qt5``.

Note that python 3.5 is not yet supported for `technical reasons`_.

Note that if you use anything else but WinPython 3.4, you have to modify
``python/default.bat`` accordingly!

.. _WinPython 3.4 Qt5: https://winpython.github.io/
.. _technical reasons: https://github.com/hibtc/cpymad/issues/32


madqt
~~~~~

After you have extracted python, you can go along to install the core of
madqt by executing (double-clicking in the explorer should be fine)::

    util\install_devel.bat

or, if you don't need a development version::

    util\install_static.bat

In the latter case, you are ready now (unless there was any error…).


cpymad
~~~~~~

So far, there is still one essential part missing: cpymad_. If you do not need
a development version of this package, consider installing the prebuilt cpymad
wheel::

    util\download_cpymad.bat

Otherwise, if you will need build both MAD-X and cpymad manually as described
in the `cpymad installation instructions`_. I will give a short summary here:

First, grab and install a recent version of cmake_. Select to add cmake to
system PATH.

Next, download MAD-X to ``src/MAD-X`` and checkout the required version. This
can be done using git as described above, or you could download and extract
the official release tarball from the website.

Now, build MAD-X (this will take a few minutes)::

    util\build_madx.bat

And finally build and install cpymad::

    util\build_cpymad.bat

.. _cpymad: https://pypi.python.org/pypi/cpymad/
.. _cpymad installation instructions: http://hibtc.github.io/cpymad/installation/windows.html
.. _cmake: https://cmake.org/


beamoptikdll
~~~~~~~~~~~~

Oh, and one more thing: Copy any additional DLLs and runtime dependencies into
the ``runtime/`` subdirectory.


Usage
-----

Once you're through with the setup process, you should be able to start MadQt
using the ``run_madqt.bat`` script in the root directory.

The ``run_python.bat`` and ``run_terminal.bat`` util can be used to open
either a python shell or command window in the same environment under which
MadQt would be opened.

``run_beamoptikdll.bat`` is used to open a simple window that can be used to
directly access the BeamOptikDLL API. This is useful for debugging.


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
