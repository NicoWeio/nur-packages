{ lib
, buildPythonPackage
, fetchPypi
, hatchling
, juliapkg
}:

buildPythonPackage rec {
  pname = "juliacall";
  version = "0.9.35";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-exrXVyr/NlG75PpVQUDw9f2XDJgg2ZivauDeuYonCtM=";
  };

  build-system = [ hatchling ];

  propagatedBuildInputs = [ juliapkg ];

  meta = {
    description = "Julia and Python in seamless harmony";
    homepage = "https://github.com/JuliaPy/PythonCall.jl";
    license = lib.licenses.mit;
  };
}
