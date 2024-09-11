#!/usr/bin/env bash
set -eu

echo "Sync submodule"
# git submodule update --init --recursive --depth=1
git submodule update --init --depth=1 rime-list 

# echo "Update docs"
# if [[ -d docs/wiki ]]; then
#     rm -rf docs/wiki
# fi
# mkdir -p docs/wiki
# cp -r rime-wiki/*.md docs/wiki/

if [[ -f rime-list/README.md ]]; then
    echo "Copy rime-list"
    cp rime-list/README.md docs/list.md
fi

echo "Build sites"
mkdocs build >/dev/null 2>&1

echo Done
