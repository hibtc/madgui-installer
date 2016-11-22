madqt-portable
==============

Folder structure and scripts for getting a portable windows version of madqt_.

.. _madqt: https://github.com/hibtc/madqt


Setup
-----

Perform the following steps to build a portable windows version of MadQt from
scratch.

Clone
~~~~~

Clone this repository with submodules::

    git clone https://github.com/hibtc/madqt-portable --recursive -j2

If you have cloned the repository without submodules, fetch them manually::

    git submodule update --init --recursive --j2

You will only be able to get ``hit_models`` and ``hit_online_control`` if you
have been granted read access to the corresponding private repositories.


WinPython
~~~~~~~~~

To get a truly portable version, including a python interpreter, install
`WinPython 2.7_` or `WinPython 3.4`_ in its own folder under ``./python/``.
Note that 3.5 is not yet supported.

.. _WinPython 2.7: https://sourceforge.net/projects/winpython/files/WinPython_2.7/
.. _WinPython 3.4: https://winpython.github.io/

Do not use the *zero* versions.


cpymad
~~~~~~

In order to use MadQt, you will need to install cpymad. You can either

- install a prebuilt binary by executing ``./tools/install_cpymad.bat``
- manually build MAD-X and cpymad by executing
  ``./tools/build_madx_and_cpymad.bat``. This takes about 30 minutes.

If required, more info on the cpymad build process can be found in the `cpymad
documentation`_

.. _cpymad documentation: http://hibtc.github.io/cpymad/installation/windows.html


pytao
~~~~~

pytao is not yet ready for use on windows.


Usage
-----

Once you're through with the setup process, you should be able to start MadQt
using the ``madqt.bat`` script in the root directory.

The ``python.bat`` and ``terminal.bat`` scripts can be used to open either a
python shell or command window in the same environment under which MadQt would
be opened.

``beamoptikdll.bat`` is used to open a simple window that can be used to
directly access the BeamOptikDLL API. This is useful for debugging.
