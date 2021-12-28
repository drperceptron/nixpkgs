{ buildPythonPackage
, fetchFromGitHub
, pygments, six, wcwidth
, pytestCheckHook, pexpect, pyte
, lib
}:

buildPythonPackage rec {
  pname = "lineedit";
  version = "0.1.6";

  src = fetchFromGitHub {
    owner = "randy3k";
    repo = "${pname}";
    rev = "refs/tags/v${version}";
    sha256 = "1j8nagd1wmx26bxc3aamxf938gvkp8c57i1mrfsqm40h6ak8vbby";
  };

  propagatedBuildInputs = [
    pygments
    six
    wcwidth
  ];

  checkInputs = [
    pytestCheckHook
    pexpect
    pyte
  ];

  meta = with lib; {
    homepage = "https://github.com/randy3k/lineedit";
    description = "a readline library based on prompt_toolkit which supports multiple modes";
    license = licenses.mit;
    maintainers = with maintainers; [ drperceptron ];
  };
}
