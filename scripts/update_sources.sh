# Execute this script from the Git bash

MADQT_ROOT="$(realpath "$(dirname "${BASH_SOURCE[0]}")"/..)"

for folder in "$MADQT_ROOT"/src/*; do
    cd $folder
    git pull
done
