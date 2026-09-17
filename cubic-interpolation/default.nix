{ lib
, stdenv
, cmake
, fetchFromGitHub
, boost
, eigen
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cubic-interpolation";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "tudo-astroparticlephysics";
    repo = "cubic_interpolation";
    rev = "v${finalAttrs.version}";
    hash = "sha256-aSiWthjxBcprCkcFVPiHqEk6pZqUHgfJUA5HqBAkUeE=";
  };

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ boost eigen ];

  unpackPhase = ''
    mkdir source
    cp -r $src/. source
    chmod -R u+w source
  '';
  sourceRoot = "source";

  cmakeFlags = [
    "-DBUILD_EXAMPLE=OFF"
    "-DBUILD_DOCUMENTATION=OFF"
    "-DBUILD_TESTING=OFF"
  ];

  meta = {
    description = "C++ library for cubic and bicubic interpolation";
    homepage = "https://github.com/tudo-astroparticlephysics/cubic_interpolation";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
