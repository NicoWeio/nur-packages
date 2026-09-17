{ pkgs }:
let
  cubicInterpolation = pkgs.callPackage ./cubic-interpolation { };
  proposal = pkgs.callPackage ./proposal {
    "cubic-interpolation" = cubicInterpolation;
  };
in
{
  "cubic-interpolation" = cubicInterpolation;
  inherit proposal;
  corsika8 = pkgs.callPackage ./corsika8 { inherit proposal; };
  crpropa = pkgs.callPackage ./crpropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
