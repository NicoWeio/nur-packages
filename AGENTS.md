## Guidelines for adding new packages
- Package recursive dependencies as well, but don't expose them as NUR packages, except if instructed otherwise.
- Building large dependencies like pytorch is off-limits; you need to use something that's cached in cache.nixos.org.
- You need to stick with NixOS unstable / 26.05 – no downgrading, especially if it affects other NUR packages of mine.
- You may apply SMALL patches.
- Run small-scale tests to verify that the package works as expected, offer to run larger tests if available.
- Give up if my requirements cannot be satisfied.

## Nitpicks
- Sort packages alphabetically in the README.md and wherever else it makes sense.
