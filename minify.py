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


def main(site_dirs):
    for base in site_dirs:
        for py_file in glob(base + r'\**\*.py', recursive=True):
            if py_compile.compile(py_file, py_file + 'c'):
                os.remove(py_file)

        for cachedir in glob(base + r'\**\__pycache__', recursive=True):
            shutil.rmtree(cachedir)


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
