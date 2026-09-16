{ lib
, buildPythonPackage
, fetchPypi
, hatchling
, click
, juliacall
, julia
, numpy
, pandas
, scikit-learn
, sympy
, typing-extensions
}:

buildPythonPackage rec {
  pname = "pysr";
  version = "2.4.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-4IhX8maMwI14RUa9YfyErLN2pBvWyb2h+89XtFo0LCs=";
  };

  build-system = [ hatchling ];

  propagatedBuildInputs = [
    click
    juliacall
    julia
    numpy
    pandas
    scikit-learn
    sympy
    typing-extensions
  ];

  # Importing PySR initializes JuliaCall and downloads SymbolicRegression.jl.
  # It is smoke-tested outside the sandboxed Nix build instead.
  doCheck = false;

  meta = {
    description = "High-performance symbolic regression in Python and Julia";
    homepage = "https://github.com/MilesCranmer/PySR";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux;
  };
}
