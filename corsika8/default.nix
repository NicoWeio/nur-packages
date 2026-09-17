{ lib
, stdenv
, cmake
, fetchgit
, fetchurl
, pkg-config
, python3
, gfortran
, rsync
, gnutar
, boost
, cli11
, eigen
, spdlog
, yaml-cpp
, arrow-cpp
, proposal
, catch2_3
, bzip2
, zlib
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "corsika8";
  version = "8.0.0.0-beta1";

  src = fetchgit {
    url = "https://gitlab.iap.kit.edu/AirShowerPhysics/corsika.git";
    rev = "0cf705d8518d2a6a8617e62113e341f3540eb3ea";
    hash = "sha256-U/h4nTQALNqK8Zv3StCCyskP1RFMTZLlkjaIEzYVNN8=";
    fetchSubmodules = true;
  };

  pythia8Src = fetchurl {
    url = "https://gitlab.com/Pythia8/releases/-/archive/pythia8312/releases-pythia8312.tar.gz";
    hash = "sha256-waM6pfoV5rcNeUbObSNyRoQoh+yE6gs138JTXIaKJ3A=";
  };

  tauolaSrc = fetchurl {
    url = "https://tauolapp.web.cern.ch/tauolapp/resources/TAUOLA.1.1.8/TAUOLA.1.1.8-LHC.tar.gz";
    hash = "sha256-P3NOipZ2goacyiwf/r0+BVViYTxAhTzIGCDYtmaAXtU=";
  };

  nativeBuildInputs = [ cmake gfortran gnutar pkg-config python3 rsync ];
  buildInputs = [
    arrow-cpp
    boost
    bzip2
    catch2_3
    cli11
    eigen
    proposal
    spdlog
    yaml-cpp
    zlib
  ];

  unpackPhase = ''
    mkdir source
    cp -r $src/. source
    chmod -R u+w source
  '';
  sourceRoot = "source";

  postPatch = ''
    patchShebangs src
    substituteInPlace CMakeLists.txt \
      --replace-fail 'set (CORSIKA_DATA_WITH_TEST ON)' 'find_package(BZip2 REQUIRED)
set (CORSIKA_DATA_WITH_TEST ON)' \
      --replace-fail 'find_package(Arrow REQUIRED)' 'find_package(Arrow REQUIRED)
find_package(Parquet REQUIRED)' \
      --replace-fail 'Parquet::parquet_static' 'Parquet::parquet_shared'
    substituteInPlace modules/pythia8/CMakeLists.txt \
      --replace-fail 'URL ''${_C8_Pythia8_Download_Dir}/pythia''${_C8_Pythia8_VERSION}.tar.bz2' 'URL file://${finalAttrs.pythia8Src}' \
      --replace-fail 'URL_MD5 0acde09714b5383ac807edb10f161dd9' 'URL_MD5 e79e924a324805e669765cd22e869dd9'
    substituteInPlace modules/tauola/CMakeLists.txt \
      --replace-fail 'http://tauolapp.web.cern.ch/tauolapp/resources/TAUOLA.1.1.8/TAUOLA.1.1.8-LHC.tar.gz' 'file://${finalAttrs.tauolaSrc}'
  '';

  doCheck = false;

  meta = {
    description = "Framework for particle-cascade simulation in astroparticle physics";
    homepage = "https://corsika-8.readthedocs.io/";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
})
