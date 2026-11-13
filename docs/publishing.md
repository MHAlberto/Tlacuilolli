# Publish Tlacuilolli

The intended repository name is `tlacuilolli`. The package manifest and initial version are in `typst.toml`. The local repository uses `main`. GitHub needs an account with permission to create a repository and Git authentication over HTTPS or SSH.

## Review the first commit

```sh
pwsh -NoProfile -File tests/run.ps1
git status --short
git add .
git diff --cached --check
git diff --cached --stat
git commit -m "Initial release of Tlacuilolli"
```

Review the staged files before committing. Include the MIT license, image credits, editable diagram sources, and the optimized assets that the examples need. Local TeX tooling, downloaded originals, test output, and compiled example PDFs belong in the ignored `build/` directory. Keep credentials and unrelated files out of the commit. [GitHub guide to importing local code](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github)

## Create the GitHub repository

With GitHub CLI installed, authenticate and run the following from the project directory when ready to publish publicly.

```sh
gh auth login
gh repo create tlacuilolli --public --source=. --remote=origin --push
```

With the GitHub web interface, create an empty repository named `tlacuilolli`. Leave the README, license, and gitignore initialization options unchecked because the local project already has them. Replace `YOUR-ACCOUNT` with the actual owner when adding the remote.

```sh
git remote add origin https://github.com/YOUR-ACCOUNT/tlacuilolli.git
git push -u origin main
```

Open the Actions tab to confirm the `Compile and test` workflow passes after the push. The repository's actual URL can then be added as `repository` in `typst.toml`. [GitHub CLI authentication](https://docs.github.com/en/github-cli/github-cli/authenticating-with-github-cli) · [GitHub guide to importing local code](https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github)

## GitHub release 0.0.2

After the final changes are committed and the workflow passes, tag the commit. Use a GitHub Release to attach generated PDF examples if you want to distribute them alongside the source.

```sh
git tag -a v0.0.2 -m "Tlacuilolli 0.0.2"
git push origin v0.0.2
gh release create v0.0.2 --verify-tag --generate-notes build/atomic-bomb.pdf build/mathematics.pdf build/literature.pdf
```

[GitHub release documentation](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository)

## Typst Universe

The [first registry submission](https://github.com/typst/packages/pull/6394) uses version `0.1.0` and is reviewed separately from the GitHub release.

1. Add the public GitHub repository URL to `typst.toml` and check that the name and version match the intended release. On November 12, 2026, the official index contained no exact entry for `tlacuilolli`. Check the index again before submitting. [Package manifest rules](https://github.com/typst/packages/blob/main/docs/manifest.md) · [Official index](https://packages.typst.org/preview/index.json)
2. Fork [`typst/packages`](https://github.com/typst/packages) and create `packages/preview/tlacuilolli/0.1.0/` in the fork. Copy `typst.toml`, `lib.typ`, `src/`, `LICENSE`, and `README.md` there. Point the submission README's project links to the corresponding files in your public repository, preferably at the release tag. If you copy linked documentation or example assets into the fork instead, keep them excluded from the download bundle using the manifest. [Submission guidelines](https://github.com/typst/packages/tree/main/docs#package-submission-guidelines) · [Package documentation](https://github.com/typst/packages/blob/main/docs/documentation.md)
3. Commit that version directory in the fork and open a pull request against `typst/packages`. After the pull request is merged and the registry build completes, users can import `@preview/tlacuilolli:0.1.0`. [Typst publication process](https://github.com/typst/packages/tree/main/docs#package-submission-in-practice)
