"""
Zip up pure, zip-safe python packages in given site-packages folders.

Usage:
    python purelib.py $PREFIX/lib/site-packages
"""

import os
import sys
from distlib.database import DistributionPath


def is_zip_safe(dist):
    """Check whether a distribution can be considered safe for zip-import."""
    if not getattr(dist, 'path', None):
        return False
    zip_safe_file = os.path.join(dist.path, 'zip-safe')
    metadata_file = os.path.join(dist.path, 'WHEEL')
    with open(metadata_file) as f:
        wheel_meta = f.read()
    purelib = 'Root-Is-Purelib: true' in wheel_meta
    zip_safe = os.path.exists(zip_safe_file)
    # This is a stronger than necessary condition, i.e. will report fewer
    # packages as safe than really are (only those that explicitly reported
    # being safe). Avoiding false negatives would require additional static
    # analysis such as using the `scan_module` and `analyze_egg` functions
    # from the `setuptools.command.bdist_egg` module. For now, we keep it
    # simple/stupid to avoid false positives:
    return zip_safe and purelib


def get_toplevel_pathes(dist):
    """Get pathes of top level modules and packages in the distribution."""
    site_dir = os.path.dirname(dist.path)
    toplevel = [m.decode('utf-8') for m in dist.modules]
    for module in toplevel:
        abspath = os.path.join(site_dir, module)
        if os.path.isdir(abspath):
            yield abspath
        elif os.path.isfile(abspath + '.pyc'):
            yield abspath + '.pyc'
        elif os.path.isfile(abspath + '.py'):
            yield abspath + '.py'
    yield dist.path


def main(site_dirs=None):
    site = DistributionPath(site_dirs)
    safe = [dist for dist in site.get_distributions() if is_zip_safe(dist)]

    pathes = [
        path
        for dist in safe
        for path in get_toplevel_pathes(dist)
    ]

    import zipfile
    zipfile.main(['--create', 'purelib.zip'] + pathes)

    from minify import trash
    trash(pathes)


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
