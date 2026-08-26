{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, numpy
, scipy
}:

buildPythonPackage rec {
  pname = "radiotools";
  version = "0.2.5";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Rw4AJrFlONY3AKdd2gjT6cIP2nuiSIwfpXWT/J4aSTg=";
  };

  nativeBuildInputs = [ flit-core ];
  propagatedBuildInputs = [ numpy scipy ];

  meta = with lib; {
    description = "Tools for radio detection of cosmic rays and neutrinos";
    homepage = "https://github.com/nu-radio/radiotools";
    license = licenses.gpl3Plus;
  };
}
