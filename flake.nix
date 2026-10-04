{
  description = "NicoWeio's NUR packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        import ./. { inherit pkgs; });

      apps = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          packages = import ./. { inherit pkgs; };
          python312 = pkgs.python312.withPackages (ps: [ ps.numpy ]);
          python314 = pkgs.python314.withPackages (ps: [ packages.jammy-flows ]);
          pythonTest = name: python: package: script:
            let
              runner = pkgs.writeShellScriptBin "test-${name}" ''
                export PYTHONPATH="${package}/${python.sitePackages}''${PYTHONPATH:+:$PYTHONPATH}"
                exec ${python}/bin/python ${script} "$@"
              '';
            in
            { type = "app"; program = "${runner}/bin/test-${name}"; };
        in
        {
          test-crpropa = pythonTest "crpropa" python312 packages.crpropa ./tests/crpropa.py;
          test-jammy-flows = pythonTest "jammy-flows" python314 packages.jammy-flows ./tests/jammy-flows.py;
          test-proposal = pythonTest "proposal" python312 packages.proposal ./tests/proposal.py;
          test-radiopropa = pythonTest "radiopropa" python312 packages.radiopropa ./tests/radiopropa.py;
          test-rainlendar2 =
            let
              runner = pkgs.writeShellScriptBin "test-rainlendar2" ''
                set -eu
                test_home=$(mktemp -d)
                trap 'rm -rf "$test_home"' EXIT
                export HOME="$test_home"
                export XDG_CONFIG_HOME="$test_home/config"
                export XDG_DATA_HOME="$test_home/data"
                export XDG_CACHE_HOME="$test_home/cache"
                set +e
                ${pkgs.coreutils}/bin/timeout 8s ${pkgs.xvfb-run}/bin/xvfb-run -a ${packages.rainlendar2}/bin/rainlendar2
                status=$?
                set -e
                if [ "$status" -ne 124 ]; then
                  echo "Rainlendar exited during startup (status $status)" >&2
                  exit 1
                fi
                echo "Rainlendar: headless startup passed"
              '';
            in
            { type = "app"; program = "${runner}/bin/test-rainlendar2"; };
        });
    };
}
