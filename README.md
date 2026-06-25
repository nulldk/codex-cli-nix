# codex-cli-nix

Personal Nix flake for packaging the official OpenAI Codex CLI releases.

This fork updates from the upstream OpenAI repository, not from another Nix
packaging repository:

- Upstream release source: `openai/codex`
- Packaged release assets: official `rust-v*` release tarballs and npm tarballs
- Update cadence: hourly GitHub Actions schedule
- Update mode: direct commit to `main` when a newer OpenAI Codex release exists
- Binary cache: none configured

## Packages

- `codex`: native Codex binary, default package
- `codex-node`: Node.js package variant

## Usage

```bash
nix run github:nulldk/codex-cli-nix
nix run github:nulldk/codex-cli-nix#codex-node
```

In a NixOS or Home Manager flake:

```nix
{
  inputs.codex-cli-nix.url = "github:nulldk/codex-cli-nix";

  outputs = { codex-cli-nix, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Example:
      environment.systemPackages = [
        codex-cli-nix.packages.${system}.default
      ];
    };
}
```

## Automatic Updates

The `Update from OpenAI Codex` workflow runs hourly and can also be triggered
manually. It:

1. Reads the current packaged version from `package.nix`.
2. Reads the latest official release tag from `openai/codex`.
3. Runs `scripts/update.sh --version <version>` when a newer release exists.
4. Recalculates all fixed-output hashes.
5. Builds `codex` and `codex-node`.
6. Commits `package.nix` and `flake.lock` directly to `main`.

This does not sync with the original packaging fork and does not use its Cachix
cache. If an OpenAI release asset hash differs from what was calculated during
the update, Nix fails instead of accepting changed content.

## Manual Update

```bash
./scripts/update.sh --check
./scripts/update.sh --version 0.142.2
nix build .#codex
./result/bin/codex --version
```

## Local Development

```bash
nix build .#codex
nix build .#codex-node
```

## License

This Nix packaging is licensed under the MIT License. OpenAI Codex itself is
distributed by OpenAI under its own license.
