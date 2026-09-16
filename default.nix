{ pkgs }: {
  crpropa = pkgs.callPackage ./crpropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python312;
    numpy = pkgs.python312Packages.numpy;
  };
  juliapkg = pkgs.python312Packages.callPackage ./juliapkg { };
  juliacall = pkgs.python312Packages.callPackage ./juliacall {
    juliapkg = pkgs.python312Packages.callPackage ./juliapkg { };
  };
  pysr = pkgs.python312Packages.callPackage ./pysr {
    juliacall = pkgs.python312Packages.callPackage ./juliacall {
      juliapkg = pkgs.python312Packages.callPackage ./juliapkg { };
    };
  };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
