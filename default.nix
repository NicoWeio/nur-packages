{ pkgs }:
let
  pythonPackages = pkgs.python312Packages;
  juliapkg = pythonPackages.callPackage ./pysr/juliapkg { };
  juliacall = pythonPackages.callPackage ./pysr/juliacall {
    inherit juliapkg;
  };
in
{
  crpropa = pkgs.callPackage ./crpropa {
    python = pkgs.python312;
    numpy = pythonPackages.numpy;
  };
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python312;
    numpy = pythonPackages.numpy;
  };
  pysr = pythonPackages.callPackage ./pysr {
    inherit juliacall;
  };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
