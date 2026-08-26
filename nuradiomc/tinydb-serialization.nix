{ lib
, buildPythonPackage
, fetchurl
, tinydb
}:

buildPythonPackage {
  pname = "tinydb-serialization";
  version = "2.2.0";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/py3/t/tinydb-serialization/tinydb_serialization-2.2.0-py3-none-any.whl";
    hash = "sha256-Au3q/WVguBHI3z45eSo33uaKxjl4ZZwhTqtZMxbFglM=";
  };

  propagatedBuildInputs = [ tinydb ];

  meta = with lib; {
    description = "Serialization support for TinyDB";
    homepage = "https://github.com/msiemens/tinydb-serialization";
    license = licenses.mit;
  };
}
