{ pkgs }: {
  crpropa = pkgs.callPackage ./crpropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  pysr = pkgs.python312Packages.callPackage ./pysr { };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
