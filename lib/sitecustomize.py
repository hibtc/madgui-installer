"""
This module is imported automatically on python startup if reachable via
PYTHONPATH. On import it adds the './site-packages' subdirectory to the
list of site-directories. This will make the packages therein importable.
"""

import os
import site
import sys

py_ver = "{}.{}".format(*sys.version_info[:2])
py_arch = ("32", "64")[sys.maxsize > 2**32]

this_dir = os.path.dirname(__file__)
site.addsitedir(os.path.join(this_dir, 'python{}-{}bit'.format(py_ver, py_arch)))
site.addsitedir(os.path.join(this_dir, '..', 'src'))
