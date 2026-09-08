# homebrew-cageforge

A [Homebrew](https://brew.sh) **tap** for
[Cageforge](https://github.com/m62624/cageforge). It provides the prebuilt
`cageforge-cli` command for macOS and Linux; the release workflow updates the
formula from the signed release assets.

This repository contains packaging only. The source code, documentation, and
issue tracker live in the [main Cageforge repository](https://github.com/m62624/cageforge).

## Formula

| Formula | Installs | Purpose |
| --- | --- | --- |
| `cageforge-cli` | `cageforge-cli` | Run explicitly selected programs through a Cageforge sandbox. |

## Install

```bash
brew tap m62624/cageforge
brew install m62624/cageforge/cageforge-cli
```

After adding the tap, the short form also works:

```bash
brew install cageforge-cli
```

Verify, upgrade, or remove it:

```bash
cageforge-cli --version
brew upgrade cageforge-cli
brew uninstall cageforge-cli
brew untap m62624/cageforge
```

Homebrew packages the macOS and Linux builds. Windows builds are distributed
from the [Cageforge Releases page](https://github.com/m62624/cageforge/releases)
through the PowerShell installer or MSI.

For the library API, embed the [`cageforge` facade](https://docs.rs/cageforge/latest/cageforge/)
in a Rust application. For a terminal or script, use `cageforge-cli` with a
TOML profile and an explicit command after `--`.

## License

Apache-2.0. See the [main repository](https://github.com/m62624/cageforge)
for the license and third-party notices.
