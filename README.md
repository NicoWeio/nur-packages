# NUR packages

Personal [Nix User Repository (NUR)](https://github.com/nix-community/NUR)
packages.

## Packages

| Package | Description |
| --- | --- |
| `crpropa` | Framework for propagating ultra-high-energy particles through space. |
| `jammy-flows` | Python library for normalizing flow PDFs on manifolds. |
| `proposal` | C++ and Python library for propagating leptons and gamma rays through matter. |
| `radiopropa` | Radio propagation in inhomogeneous media ray tracing. |
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

## Development

Build all packages exported by the top-level `default.nix`:

```sh
for attribute in $(nix-env -f . -qaP --arg pkgs 'import <nixpkgs> { config.allowUnfree = true; }' --json | jq -r 'keys[]'); do
	nix-build --no-out-link -A "$attribute" --arg pkgs 'import <nixpkgs> { config.allowUnfree = true; }'
done
```

The GitHub Actions workflow performs the same evaluation and sequential build on
every push and pull request.

### Runtime tests

Run a package's behavior test on demand:

```sh
nix run .#test-crpropa
nix run .#test-jammy-flows
nix run .#test-proposal
nix run .#test-radiopropa
nix run .#test-rainlendar2
```

The four library tests exercise their installed Python bindings; Rainlendar's test
starts the desktop application in a virtual display for eight seconds. These are
flake apps, so they are not run by a package build or the regular CI workflow.
After committing new test files, the commands above work from this Git checkout.
While the files are still untracked, use `nix run path:.#test-crpropa` (and the
corresponding names for the other tests) to include them in the local flake.

`nix run .#rainlendar2` launches the installed application. The other four
packages are libraries and have no package executable; use their `test-*` apps
to verify them.

### CI binary cache

CI uses [Cachix](https://cachix.org) to restore and publish Nix store paths.
Create the Cachix cache, then configure these GitHub repository settings:

- Variable `CACHIX_CACHE_NAME`: the name of the Cachix cache.
- Secret `CACHIX_AUTH_TOKEN`: a per-cache token with write access.

Pull requests from forks do not receive the secret, so they can only restore
from a public cache and do not publish build outputs.
