{ lib
, stdenvNoCC
, fetchurl
, makeWrapper
, python3
, gfortran
, gcc
, gnumake
, bash
, coreutils
, gzip
, perl
, which
, writeShellScript
}:

let
  python = python3.withPackages (ps: [ ps.six ]);
  runner = writeShellScript "madgraph-runner" ''
    mg5Dir="''${XDG_CACHE_HOME:-$HOME/.cache}/madgraph/3.7.0"
    if [ ! -e "$mg5Dir/bin/mg5_aMC" ]; then
      ${coreutils}/bin/mkdir -p "$(dirname "$mg5Dir")"
      ${coreutils}/bin/cp -a "$1" "$mg5Dir"
      ${coreutils}/bin/chmod -R u+w "$mg5Dir"
    fi
    shift
    exec ${python}/bin/python "$mg5Dir/bin/mg5_aMC" "$@"
  '';
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "madgraph";
  version = "3.7.0";

  src = fetchurl {
    url = "https://launchpad.net/mg5amcnlo/3.0/3.6.x/+download/MG5_aMC_v${finalAttrs.version}.tar.gz";
    hash = "sha256-sVHe4KRr/WJZWcoCAqpfOibtVJKg+5jh88FkyGCUeHA=";
  };

  nativeBuildInputs = [ makeWrapper ];

  # The distributed source intentionally contains optional integration stubs
  # whose targets are supplied by external tools.
  dontCheckForBrokenSymlinks = true;

  installPhase = ''
    runHook preInstall

    patchShebangs .
    mkdir -p "$out/share/madgraph" "$out/bin"
    cp -a . "$out/share/madgraph"
    makeWrapper ${runner} "$out/bin/mg5_aMC" \
      --add-flags "$out/share/madgraph" \
      --prefix PATH : ${lib.makeBinPath [ bash coreutils gcc gfortran gnumake gzip perl which ]}

    runHook postInstall
  '';

  meta = {
    description = "Framework for the automated computation of particle-physics processes";
    homepage = "https://launchpad.net/mg5amcnlo";
    license = lib.licenses.gpl3Plus;
    maintainers = [ ];
    mainProgram = "mg5_aMC";
    platforms = lib.platforms.unix;
  };
})
