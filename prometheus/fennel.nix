{ lib
, fetchFromGitHub
, pythonPackages
}:

pythonPackages.buildPythonPackage rec {
  pname = "fennel-seed";
  version = "2.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "MeighenBergerS";
    repo = "fennel";
    rev = "v${version}";
    hash = "sha256-6ThUCWLUgfnMSjPWbX1E4e6QJCDJMZSjlR8aE+kgYLo=";
  };

  build-system = with pythonPackages; [ setuptools wheel ];
  dependencies = with pythonPackages; [ pyyaml numpy scipy pandas jax jaxlib ];

  pythonImportsCheck = [ "fennel" ];

  meta = {
    description = "Cherenkov light yield models for tracks and cascades";
    homepage = "https://github.com/MeighenBergerS/fennel";
    license = lib.licenses.mit;
  };
}
