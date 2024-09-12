# Squirrel Release Manual

1.  Update the version of `squirrel/data/squirrel.yaml` if there are changes since last release.

1.  Run `package/bump_version` to update app version; push the commit and version tag to GitHub.

    Pushing the version tag will trigger a release CI build on GitHub Actions.

1.  At the [GitHub Releases](https://github.com/rime/squirrel/releases) page, edit the draft release created from CI, publish it as latest release, then download the zip archive.

1.  Copy/move the downloaded file to local source tree, under `squirrel/package/`.

1.  Put private key file in `squirrel/package/sign/`.

    The private key for signing auto-update Squirrel releases is owned by Rime Keyholder.

1.  In [GitHub Actions](https://github.com/rime/squirrel/actions), find the release CI workflow run with the version tag, then copy the sha256 checksum from build log, near the end of "Build Squirrel" step.

    For example:

        bash package/make_archive
        adding: Squirrel.pkg (deflated 0%)
        sha256 checksum:
        8f3f3e9aa2e923e88220ea603dcbd3b70c3a88d8177a6c487cfdccc946b25379  Squirrel-0.16.1.zip

1.  Run
    ```shell
    make sign-archive checksum=8f3f3e9aa2e923e88220ea603dcbd3b70c3a88d8177a6c487cfdccc946b25379
    ```
    The script generates `package/*appcast.xml`.

1.  Prepare to update project website.

    Assume GitHub repo `rime/<project>` is cloned to local directory `./<project>`; do
    ```shell
    cp squirrel/package/appcast.xml home/blog/source/release/squirrel/appcast.xml
    cp squirrel/package/testing-appcast.xml home/blog/source/testing/squirrel/appcast.xml

    cat <<EOF > home/blog/source/release/squirrel/index.md
    title: 【鼠鬚管】更新日誌
    comments: false
    $(date '+date: %Y-%m-%d %H:%M:%S')
    ---

    EOF
    cat squirrel/CHANGELOG.md >> home/blog/source/release/squirrel/index.md
    cp home/blog/source/release/squirrel/index.md  home/blog/source/testing/squirrel/index.md
    ```

1.  Also update latest Squirrel version and download URL in
    - `home/blog/source/_data/downloads.yaml`
    - `home/blog/source/download/index.md`

1.  Test the website locally with Hexo:
    ```shell
    npm install -g hexo-cli
    cd home/blog
    npm install
    hexo server
    open https://0.0.0.0:4000/
    ```
    Verify the updated links are valid.

1.  Commit changes with commit message `chore(release): squirrel ${version} :tada:` and push to [`rime/home`](https://github.com/rime/home).

    This will trigger automated update to the site <https://rime.im>.

