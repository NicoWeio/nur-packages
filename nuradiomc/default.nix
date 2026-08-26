{ lib
, buildPythonPackage
, fetchPypi
, poetry-core
, astropy
, numpy
, scipy
, matplotlib
, aenum
, awkward
, cython
, dash
, filelock
, future
, h5py
, numba
, peakutils
, pymongo
, pyyaml
, requests
, tinydb
, toml
, uproot
, radiotools
, tinydb-serialization
}:

buildPythonPackage rec {
  pname = "nuradiomc";
  version = "3.0.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-OcgM001btZ43aaykCbnOvi3Q41SUHkTnQvN+ZWxoi+E=";
  };

  nativeBuildInputs = [ poetry-core ];
  propagatedBuildInputs = [
    astropy
    numpy
    scipy
    matplotlib
    aenum
    awkward
    cython
    dash
    filelock
    future
    h5py
    numba
    peakutils
    pymongo
    pyyaml
    radiotools
    requests
    tinydb
    tinydb-serialization
    toml
    uproot
  ];

  pythonImportsCheck = [ "NuRadioMC" "NuRadioReco" ];

  meta = with lib; {
    description = "Monte Carlo for radio detection of neutrinos";
    homepage = "https://github.com/nu-radio/NuRadioMC";
    license = licenses.gpl3Plus;
  };
}
