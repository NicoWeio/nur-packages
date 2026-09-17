{ lib
, stdenv
, cmake
, fetchFromGitHub
, cubic-interpolation
, nlohmann_json
, spdlog
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "proposal";
  version = "7.6.2";

  src = fetchFromGitHub {
    owner = "tudo-astroparticlephysics";
    repo = "PROPOSAL";
    rev = finalAttrs.version;
    hash = "sha256-R1x1+wG504nx6X1aZ0GuKzKVTTOUuyST7r5dM65JCjw=";
  };

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ cubic-interpolation nlohmann_json spdlog ];

  unpackPhase = ''
    mkdir source
    cp -r $src/. source
    chmod -R u+w source
  '';
  sourceRoot = "source";

  cmakeFlags = [
    "-DBUILD_DOCUMENTATION=OFF"
    "-DBUILD_EXAMPLE=OFF"
    "-DBUILD_PYTHON=OFF"
    "-DBUILD_TESTING=OFF"
  ];

  meta = {
    description = "Monte Carlo propagation of charged leptons and photons";
    homepage = "https://github.com/tudo-astroparticlephysics/PROPOSAL";
    license = lib.licenses.lgpl3Only;
    platforms = lib.platforms.linux;
  };
})
