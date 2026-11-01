# mach25/homebrew-ncompose

Homebrew tap for [ncompose](https://github.com/mach25/ncompose), Docker Compose for native
macOS binaries.

```sh
brew install mach25/ncompose/ncompose
ncompose system install   # once: the boot-time loopback alias pool (asks for sudo)
```

## Releasing a new version

1. Bump `version` in ncompose's `Cargo.toml`, commit, then `git tag vX.Y.Z && git push origin vX.Y.Z`.
   The release workflow publishes `ncompose-X.Y.Z-macos-universal.tar.gz` and its `.sha256`.
2. Here, update `url` and `sha256` in `Formula/ncompose.rb`, then commit and push.
