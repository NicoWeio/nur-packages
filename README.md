# NUR packages

Personal [Nix User Repository (NUR)](https://github.com/nix-community/NUR)
packages.

## Packages

| Package | Description |
| --- | --- |
| `captivePortalAutoLogin` | Linux CLI that detects and solves supported captive portals. |
| `rainlendar2` | Customizable desktop calendar (Rainlendar Lite). |

## Installation

Once this repository is registered in NUR, install a package through the NUR
namespace:

```nix
environment.systemPackages = [
	pkgs.nur.repos.NicoWeio.rainlendar2
];
```

`rainlendar2` is unfree, so the Nixpkgs configuration must allow unfree
packages:

```nix
nixpkgs.config.allowUnfree = true;
```

To run Rainlendar directly without installing it:

```sh
nix run github:NicoWeio/nur-packages#rainlendar2
```

Run a one-shot captive-portal check without installing it:

```sh
nix run github:NicoWeio/nur-packages#captivePortalAutoLogin -- --oneshot
```

### Captive Portal Auto Login dependencies

The package builds the upstream JVM Linux CLI. Its Gradle dependency lockfile
must be generated when the upstream dependencies change:

```sh
updater=$(nix build --no-link --print-out-paths .#updateCaptivePortalAutoLoginDeps)
"$updater"
```

Commit the updated `captive-portal-auto-login/gradle-deps.json` before running
`nix build .#captivePortalAutoLogin`.

## Development

Build all packages exported by the top-level `default.nix`:

```sh
for attribute in $(nix-env -f . -qaP --arg pkgs 'import <nixpkgs> { config.allowUnfree = true; }' --json | jq -r 'keys[]'); do
	nix-build --no-out-link -A "$attribute" --arg pkgs 'import <nixpkgs> { config.allowUnfree = true; }'
done
```

The GitHub Actions workflow performs the same evaluation and sequential build on
every push and pull request.
