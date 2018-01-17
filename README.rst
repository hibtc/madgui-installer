madqt-portable
==============

Folder structure and scripts for getting a portable windows version of madqt_.

.. _madqt: https://github.com/hibtc/madqt


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


Setup
-----

Perform the following steps to build a portable windows version of MadQt from
scratch. First, clone this repository itself::

    git clone https://github.com/hibtc/madqt-portable

To get a truly portable version, including a python interpreter, install
`WinPython 2.7_` or `WinPython 3.4`_ in its own folder under ``python/``.
Note that 3.5 is not yet supported for `technical reasons`_.

.. _WinPython 2.7: https://sourceforge.net/projects/winpython/files/WinPython_2.7/
.. _WinPython 3.4: https://winpython.github.io/
.. _technical reasons: https://github.com/hibtc/cpymad/issues/32

Do not use the *zero* versions.

After installing WinPython, modify ``python/default.bat`` accordingly.


Static installation
~~~~~~~~~~~~~~~~~~~

If you're not going to do any development on the package itself, the easiest
way to get all the packages is by executing ``util/INSTALL.bat``. This will
download and install the following packages as well as their dependencies into
``lib/`` using the configured python interpreter:

- minrpc_, cpymad_, madqt_, pydicti_ (maintained by us)
- numpy_, matplotlib_, six_, PyYAML_, docutils_, ipython_, qtconsole_, docopt_, `pint 0.6`_

If you have trouble installing cpymad_, you may need to `build cpymad and
MAD-X manually`_. If this doesn't work, please give us a note.

.. _minrpc: https://pypi.python.org/pypi/minrpc/
.. _cpymad: https://pypi.python.org/pypi/cpymad/
.. _madqt: https://github.com/hibtc/madqt
.. _pydicti: https://pypi.python.org/pypi/pydicti/
.. _numpy: https://pypi.python.org/pypi/numpy/
.. _matplotlib: https://pypi.python.org/pypi/matplotlib/
.. _six: https://pypi.python.org/pypi/six/
.. _docutils: https://pypi.python.org/pypi/docutils/
.. _ipython: https://pypi.python.org/pypi/ipython/
.. _qtconsole: https://pypi.python.org/pypi/qtconsole/
.. _pint 0.6: https://pypi.python.org/pypi/Pint/0.6
.. _PyYAML: https://pypi.python.org/pypi/PyYAML/
.. _docopt: https://pypi.python.org/pypi/docopt/
.. _build cpymad and MAD-X manually: http://hibtc.github.io/cpymad/installation/windows.html


Development version
~~~~~~~~~~~~~~~~~~~

The git repositories of related packages needed while developing MadQt can be
cloned by executing::

    git submodule update --init --recursive -j2

In particular, this fetches the repositories at::

    https://github.com/hibtc/minrpc
    https://github.com/hibtc/cpymad
    https://github.com/hibtc/madqt
    https://github.com/hibtc/madseq
    https://github.com/hibtc/pytao
    https://bitbucket.org/coldfix/hit-models
    https://bitbucket.org/coldfix/hit-online-control

Note that, currently,

- ``madseq`` is related but not a dependency,
- ``pytao`` will be required to interface with bmad, but is currently
  unsupported,
- ``hit-models`` and ``hit-online-control`` are private repositories needed
  for working with the HIT sequences. These can only be cloned if you have
  been granted read access.

**cpymad**

There is one thing left to get MadQt working: Use the cpymad installation
instructions to `build MAD-X and cpymad manually`_. Warning ahead: this is
likely to fail and involve some debugging.

**pytao**

pytao is not yet ready for use on windows.


pytao
~~~~~

Building pytao on windows
using pytao on windows -> set distribution vars


In order to use MadQt with `Bmad/tao`_, build Bmad with MSYS2_ as described on
`Information for Windows Setup of a Bmad Distribution`_

.. _Bmad/tao: https://www.classe.cornell.edu/~dcs/bmad/
.. _MSYS2: http://msys2.github.io/
.. _Information for Windows Setup of a Bmad Distribution:
        https://wiki.classe.cornell.edu/ACC/ACL/WindowsSetup

Then execute ``util/build_pytao.bat`` to build pytao.

    ->

    python setup.py build_ext --inplace
    python setup.py egg_info



Usage
-----

Once you're through with the setup process, you should be able to start MadQt
using the ``run_madqt.bat`` script in the root directory.

The ``run_python.bat`` and ``run_terminal.bat`` util can be used to open
either a python shell or command window in the same environment under which
MadQt would be opened.

``run_beamoptikdll.bat`` is used to open a simple window that can be used to
directly access the BeamOptikDLL API. This is useful for debugging.


Folders
-------

::

    bin                         Binaries installed by python packages
    lib                         Statically installed python packages
    python                      Python distributions
    runtime                     Runtime libraries (Put BeamOptikDLL.dll here)
    src                         Source for python packages under development
    util                        Install scripts and utilities
