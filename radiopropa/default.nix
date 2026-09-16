{ lib
, stdenv
, cmake
, fetchFromGitHub
, hdf5
, numpy
, pkg-config
, python
, swig
, zlib
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "radiopropa";
  version = "1.0.0-unstable-2025-04-14";
  src = fetchFromGitHub {
    owner = "nu-radio";
    repo = "RadioPropa";
    rev = "544a2d6c4e284e3d724cb741dc481245a0f633d7";
    hash = "sha256-xurq6t8V6icB5ekXXQ0mPf9S1awKXLitNFFmF1mHaVk=";
  };

  unpackPhase = "mkdir -p build-source; cp -r ${finalAttrs.src}/. build-source; chmod -R u+w build-source";
  sourceRoot = "build-source/radiopropa";

  nativeBuildInputs = [ cmake pkg-config python swig ];
  buildInputs = [ hdf5 python zlib ];
  propagatedBuildInputs = [ numpy ];

  cmakeFlags = [
    "-DENABLE_GIT=OFF"
    "-DENABLE_TESTING=OFF"
    "-DPYTHON_EXECUTABLE=${python.interpreter}"
    "-DPYTHON_INCLUDE_DIR=${python}/include/python${python.pythonVersion}"
    "-DPYTHON_LIBRARY=${python}/lib/libpython${python.pythonVersion}.so"
  ];

  doCheck = false;

  meta = {
    description = "Radio propagation in inhomogeneous media ray tracing";
    homepage = "https://github.com/nu-radio/RadioPropa";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "radiopropa";
  };
})
