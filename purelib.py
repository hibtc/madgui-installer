"""
Zip up pure, zip-safe python packages in given site-packages folders.

Usage:
    python purelib.py $PREFIX/lib/site-packages
"""

import os
import sys
from distlib.database import DistributionPath
import setuptools.command.bdist_egg as bdist_egg
from setuptools.command.bdist_egg import (
    analyze_egg, scan_module as _scan_module)


def scan_module(*args, **kwargs):
    try:
        return _scan_module(*args, **kwargs)
    except ValueError:
        return True

bdist_egg.scan_module = scan_module


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
    return purelib and (zip_safe or analyze_dist(dist))


def analyze_dist(dist):
    # Somewhat unsafe static analysis that tries to determine if a package is
    # safe for zip-import.
    toplevel = [
        path
        for path, hash, size in dist.list_installed_files()
        if os.path.split(path)[0] == ''
    ]
    if any(p.endswith('.pth') for p in toplevel):
        return False
    for abspath in get_toplevel_pathes(dist):
        if os.path.isdir(abspath):
            if not analyze_egg(abspath, []):
                return False
        elif abspath.endswith('.pyc'):
            base, name = os.path.split(abspath)
            if not scan_module(base, base, name, []):
                return False
    return True


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
