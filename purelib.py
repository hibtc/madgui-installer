"""
Analyze zip-safety of site packages.

Usage:
    site_analyze [-x PKG]... [-i PKG]... [PATHES...]

Options:
    -x PKG, --exclude PKG       Blacklist package, never modify
    -i PKG, --include PKG       Whitelist package, always modify
"""

from docopt import docopt

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
    print(dist.name, end=".. " + " " * (25 - len(dist.name)))
    if not getattr(dist, 'path', None):
        print("NO PATH")
        return False

    with open(os.path.join(dist.path, 'WHEEL')) as f:
        if 'Root-Is-Purelib: true' not in f.read():
            print("IMPURE!")
            return False

    toplevel = [m.decode('utf-8') for m in dist.modules] + [
        path
        for path, hash, size in dist.list_installed_files()
        if os.path.split(path)[0] in ('', '__pycache__')
    ]

    if any(p.endswith('.pth') for p in toplevel):
        return False

    site_dir = os.path.dirname(dist.path)

    for p in toplevel:
        print(p, file=sys.stderr)
        abspath = os.path.join(site_dir, p)

        if os.path.isdir(abspath):
            if not analyze_egg(abspath, []):
                print("-> unsafe")
                return False
        elif p.endswith('.pyc'):
            base, name = os.path.split(abspath)
            if not scan_module(base, base, name, []):
                print("-> unsafe")
                return False

    print("-> ok")
    return True


def main(args=None):
    opts = docopt(__doc__, args)
    path = opts['PATHES'] or None
    site = DistributionPath(path)

    blacklisted = {s.lower() for s in opts['--exclude']}
    whitelisted = {s.lower() for s in opts['--include']}

    dists = [
        (dist,
         dist.name.lower() in whitelisted or
         dist.name.lower() not in blacklisted and is_zip_safe(dist))
        for dist in site.get_distributions()
    ]

    print("\n\nSAFE:")
    for dist in [d for d, s in dists if s]:
        dist_name = os.path.basename(dist.path)
        print('  {!r}: {}'.format(dist_name, ''.join(
            '\n    - {!r}'.format(name.decode('utf-8'))
            for name in dist.modules)))

    print("\n\nUNSAFE:")
    for dist in [d for d, s in dists if not s]:
        dist_name = os.path.basename(dist.path)
        print('  {!r}: {}'.format(dist_name, ''.join(
            '\n    - {!r}'.format(name.decode('utf-8'))
            for name in dist.modules)))

    print("\n")
    print("NUM_SAFE:", sum(s for d, s in dists))
    print("NUM_UNSAFE:", sum(not s for d, s in dists))

    pathes = []
    for dist in [d for d, s in dists if s]:
        site_dir = os.path.dirname(dist.path)
        toplevel = [m.decode('utf-8') for m in dist.modules]
        for module in toplevel:
            abspath = os.path.join(site_dir, module)
            if os.path.isdir(abspath):
                pathes.append(abspath)
            elif os.path.isfile(abspath + '.pyc'):
                pathes.append(abspath + '.pyc')
            elif os.path.isfile(abspath + '.py'):
                pathes.append(abspath + '.py')

    import zipfile
    zipfile.main(['--create', 'purelib.zip'] + pathes)

    import shutil
    for p in pathes:
        if os.path.isdir(p):
            shutil.rmtree(p)
        else:
            os.remove(p)


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
