{ stdenv, fetchFromGitHub, lib
, automake, autoconf
}:

stdenv.mkDerivation rec {
  pname = "qstat";
  version = "2.15";

  src = fetchFromGitHub {
    owner = "multiplay";
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "082nc7hhmzx9dizrn9li4xybzvcy0fpzgc7sfq3xsr3rybi2rawl";
  };

  buildInputs = [ automake autoconf ];
  enableParallelBuilding = true;

  preConfigure = ''
    ./autogen.sh
  '';

  meta = with lib; {
    homepage = "https://github.com/multiplay/qstat";
    description = "QStat is a command-line program that displays information about Internet game servers";
    license = licenses.artistic2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ drperceptron ];
  };
}
