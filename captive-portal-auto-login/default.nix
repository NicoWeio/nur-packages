{ lib
, stdenv
, fetchFromGitHub
, gradle_8
, makeWrapper
, jre_headless
, networkmanager
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "captive-portal-auto-login";
  version = "unstable-20260914";

  src = fetchFromGitHub {
    owner = "binarynoise";
    repo = "CaptivePortalAutoLogin";
    rev = "7fa49621ccabbb6705d581d85dbe1221f0d4558d";
    hash = "sha256-00Ks1d9wTNlP+dEh/Lab1PbKSwoslq9qZCQUnyB+A2M=";
  };

  nativeBuildInputs = [ gradle_8 makeWrapper ];
  mitmCache = gradle_8.fetchDeps {
    pkg = finalAttrs.finalPackage;
    data = ./gradle-deps.json;
  };
  gradleBuildTask = ":linux:shadowJar";
  dontUseGradleCheck = true;

  installPhase = ''
    runHook preInstall
    install -Dm444 linux/build/libs/linux-shadow.jar \
      "$out/share/java/captive-portal-auto-login.jar"
    makeWrapper ${jre_headless}/bin/java "$out/bin/captive-portal-auto-login" \
      --prefix PATH : ${lib.makeBinPath [ networkmanager ]} \
      --add-flags "-jar $out/share/java/captive-portal-auto-login.jar"
    runHook postInstall
  '';

  passthru.updateDeps = finalAttrs.mitmCache.updateScript;

  meta = {
    description = "Automatically solve supported captive portals";
    homepage = "https://github.com/binarynoise/CaptivePortalAutoLogin";
    license = lib.licenses.unfreeRedistributable;
    platforms = lib.platforms.linux;
    mainProgram = "captive-portal-auto-login";
  };
})
