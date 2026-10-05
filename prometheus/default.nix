{ lib
, autoPatchelfHook
, fetchFromGitHub
, python
, proposal
, stdenv
}:

let
  ps = python.pkgs;
  fennel = ps.callPackage ./fennel.nix { pythonPackages = ps; };
in
ps.buildPythonPackage rec {
  pname = "prometheus";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Harvard-Neutrino";
    repo = "prometheus";
    rev = "5f5b14cb0b8a697f5b6bd41f74e11c6bd4c1a4c8";
    hash = "sha256-34BZiJpLSU1CSzNxbdc24tT/BMrPQ/QVQxaPq6VlMt0=";
  };

  build-system = [ ps.poetry-core ];
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];
  # The existing PROPOSAL C++ derivation installs its Python module without
  # wheel metadata, so the wheel metadata check cannot recognize it.
  dontCheckRuntimeDeps = true;
  dependencies = with ps; [
    awkward
    fennel
    fsspec
    h5py
    jax
    jaxlib
    matplotlib
    numpy
    optax
    pandas
    pyarrow
    pyyaml
    scipy
    tqdm
    uproot
    proposal
  ];

  # Prometheus locates resources next to the installed package's parent.
  postInstall = ''
    cp -r resources "$out/${python.sitePackages}/resources"
  '';

  pythonImportsCheck = [ "proposal" "prometheus" ];

  meta = {
    description = "Neutrino telescope simulation in ice and water";
    homepage = "https://harvard-neutrino.github.io/prometheus/";
    license = lib.licenses.lgpl21Only;
    platforms = lib.platforms.linux;
  };
}
