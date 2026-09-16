{ pkgs }: {
  radiopropa = pkgs.callPackage ./radiopropa {
    python = pkgs.python311;
    numpy = pkgs.python311Packages.numpy;
  };
  rainlendar2 = pkgs.callPackage ./rainlendar2 { };
  # someOtherTool = pkgs.callPackage ./some-other-tool { };
}
