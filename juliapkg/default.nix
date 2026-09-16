{ lib
, buildPythonPackage
, fetchPypi
, filelock
, hatchling
, semver
, tomli
, tomlkit
}:

buildPythonPackage rec {
  pname = "juliapkg";
  version = "0.1.26";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Jxa21avL7ssFl5TFaeQKbH7IzixmpKVuAayCLSUeQqE=";
  };

  build-system = [ hatchling ];

  propagatedBuildInputs = [
    filelock
    semver
    tomli
    tomlkit
  ];

  pythonImportsCheck = [ "juliapkg" ];

  meta = {
    description = "Julia version manager and package manager";
    homepage = "https://github.com/JuliaPy/pyjuliapkg";
    license = lib.licenses.mit;
  };
}
