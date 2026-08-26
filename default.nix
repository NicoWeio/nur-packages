{ pkgs }:
let
  pythonPackages = pkgs.python312Packages.overrideScope (_final: prev: {
    inline-snapshot = prev.inline-snapshot.overridePythonAttrs (_: {
      doCheck = false;
    });
  });
in
{
  crpropa = pkgs.callPackage ./crpropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  nuradiomc = pythonPackages.callPackage ./nuradiomc {
    radiotools = pythonPackages.callPackage ./nuradiomc/radiotools.nix { };
    tinydb-serialization = pythonPackages.callPackage ./nuradiomc/tinydb-serialization.nix { };
  };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
