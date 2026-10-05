{ pkgs }:
let
  pythonPackages = pkgs.python314Packages;
  healpy = pythonPackages.callPackage ./jammy-flows/healpy.nix { };
  mhealpy = pythonPackages.callPackage ./jammy-flows/mhealpy.nix { inherit healpy; };
  prometheusPython = pkgs.python312.override {
    packageOverrides = self: super: {
      # The full JAX suite has failures on this nixpkgs revision. Prometheus
      # checks its own imports after installation.
      jax = super.jax.overridePythonAttrs (_: { doCheck = false; });
    };
  };
  proposal = pkgs.callPackage ./proposal {
    python = pkgs.python312;
    pybind11 = pkgs.python312Packages.pybind11;
  };
in
{
  crpropa = pkgs.callPackage ./crpropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  jammy-flows = pythonPackages.callPackage ./jammy-flows { inherit mhealpy; };
  inherit proposal;
  prometheus = pkgs.callPackage ./prometheus {
    python = prometheusPython;
    inherit proposal;
  };
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
}
