{ buildPythonPackage
, fetchFromGitHub
, python, isPy27
, R
, cffi, six, backports-shutil-which
, pytestCheckHook, pytest, pytest-mock, pytest-runner, rWrapper, rPackages
, lib
}:

buildPythonPackage rec {
  pname = "rchitect";
  version = "0.3.35";

  src = fetchFromGitHub {
    owner = "randy3k";
    repo = "${pname}";
    rev = "refs/tags/v${version}";
    sha256 = "16r1fzqzx5s6s1b02dm1124s0c8myxaysnar7r18r8m11khaimfv";
  };

  propagatedBuildInputs = [
    cffi
    six
  ] ++ lib.optional (isPy27) backports-shutil-which;

  postBuild = ''
    ${python.interpreter} build.py
  '';

  pythonImportsCheck = [ "rchitect" ];

  checkInputs = [
    pytestCheckHook
    pytest
    pytest-mock
    pytest-runner
    R
  ];

  disabledTests = [
    "test_completion"
    "test_rcopy_reticulate_object"
    "test_r_to_py_rchitect_object"
    "test_rprint"
  ];

  meta = with lib; {
    homepage = "https://github.com/randy3k/rchitect";
    description = "interoperate R with Python";
    license = licenses.mit;
    maintainers = with maintainers; [ drperceptron ];
  };
}
