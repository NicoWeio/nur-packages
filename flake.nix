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
          pythonPackages = pkgs.python312Packages;
          juliapkg = pythonPackages.callPackage ./pysr/juliapkg { };
          juliacall = pythonPackages.callPackage ./pysr/juliacall {
            inherit juliapkg;
          };
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
          pysr = pythonPackages.callPackage ./pysr {
            inherit juliacall;
          };
          rainlendar2 = pkgs.callPackage ./rainlendar2 { };
        });
    };
}
