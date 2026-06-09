#!/usr/bin/env bash
set -eu

echo "install deps"
pip install -r requirements-zensical.txt >/dev/null 2>&1

if [[ -f .gitmodules ]]; then
    echo "Sync submodule"
    git submodule update --depth=1 --init --remote --recursive rime-list
fi

readme_file="rime-list/README.md"
if [[ -f $readme_file ]]; then
    echo "Copy rime-list"
    # cp rime-list/README.md docs/list.md
    sed -E 's/(!\[[^]]*\]\([^)]+\))/\1{ loading=lazy }/g' $readme_file >docs/list.md
fi

echo "Build sites"
zensical build >/dev/null 2>&1

echo Done
