from glob import glob
import sys
import os
import shutil
import py_compile

for base in sys.argv[1:]:
    for py_file in glob(base + r'\**\*.py', recursive=True):
        if py_compile.compile(py_file, py_file + 'c'):
            os.remove(py_file)

    for cachedir in glob(base + r'\**\__pycache__', recursive=True):
        shutil.rmtree(cachedir)
