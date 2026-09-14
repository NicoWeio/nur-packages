{
  description = "Rainlendar package";

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
          captivePortalAutoLogin = pkgs.callPackage ./captive-portal-auto-login { };
        in
        {
          inherit captivePortalAutoLogin;
          updateCaptivePortalAutoLoginDeps = captivePortalAutoLogin.updateDeps;
          rainlendar2 = pkgs.callPackage ./rainlendar2 { };
        });
    };
}
