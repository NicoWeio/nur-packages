{ pkgs }:
let
  pythonPackages = pkgs.python312Packages.overrideScope (_final: prev: {
    inline-snapshot = prev.inline-snapshot.overridePythonAttrs (_: {
      doCheck = false;
    });
  });
in
{
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  nuradiomc = pythonPackages.callPackage ./nuradiomc {
    radiotools = pythonPackages.callPackage ./nuradiomc/radiotools.nix { };
    tinydb-serialization = pythonPackages.callPackage ./nuradiomc/tinydb-serialization.nix { };
  };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
