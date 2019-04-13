"""
Minify site-packages directory by removing .py file (leaving only .pyc in
their place).

Usage:
    python minify.py $VIRTUAL_ENV/lib/site-packages
"""

from glob import glob
import sys
import os
import shutil
import py_compile
import zipfile


def main(site_dirs):
    for base in site_dirs:
        trash(glob(base + r'\**\testsuite', recursive=True))
        trash(glob(base + r'\**\tests', recursive=True))

        for py_file in glob(base + r'\**\*.py', recursive=True):
            py_compile.compile(py_file, py_file + 'c')

        trash(glob(base + r'\**\*.py', recursive=True))
        trash(glob(base + r'\**\__pycache__', recursive=True))

    dist_info = sum([glob(base + r'\*.dist-info') for base in sys.argv[1:]], [])
    zipfile.main(['--create', r'pkg\distinfo.zip'] + dist_info)
    trash(dist_info)


def trash(pathes, base='.', trash_dir='trash'):
    for path in pathes:
        if trash_dir is None:
            shutil.rmtree(path)
        elif os.path.isfile(path):
            dest = os.path.join(trash_dir, os.path.relpath(path, base))
            os.makedirs(os.path.dirname(dest), exist_ok=True)
            os.rename(path, dest)
        elif os.path.isdir(path):
            for root, dirs, files in os.walk(path):
                dest = os.path.join(trash_dir, os.path.relpath(root, base))
                os.makedirs(dest, exist_ok=True)
                for file in files:
                    os.rename(
                        os.path.join(root, file),
                        os.path.join(dest, file))


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
