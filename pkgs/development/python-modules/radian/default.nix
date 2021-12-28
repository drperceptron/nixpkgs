{ buildPythonPackage
, fetchFromGitHub
, makeWrapper, pytest-runner
, lineedit, pygments, R, rchitect
, pytestCheckHook, coverage, pexpect, pyte
, lib
}:

buildPythonPackage rec {
  pname = "radian";
  version = "0.5.13";

  src = fetchFromGitHub {
    owner = "randy3k";
    repo = "${pname}";
    rev = "refs/tags/v${version}";
    sha256 = "1sdbcjjbx2y310y60f77nd2g7ipmhp82pxr83j3x79417d3r210p";
  };

  nativeBuildInputs = [ makeWrapper pytest-runner ];

  propagatedBuildInputs = [
    lineedit
    pygments
    R
    rchitect
  ];

  pythonImportsCheck = [ "radian" ];

  checkInputs = [
    pytestCheckHook
    coverage
    pexpect
    pyte
  ];

  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/radian --set R_HOME ${R}/lib/R
  '';

  meta = with lib; {
    homepage = "https://github.com/randy3k/radian";
    description = "an alternative console for the R program with multiline editing and rich syntax highlight";
    license = licenses.mit;
    maintainers = with maintainers; [ drperceptron ];
  };
}
