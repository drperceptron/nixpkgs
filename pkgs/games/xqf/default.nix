{ stdenv, fetchFromGitHub, lib, pkgs
, cmake, pkg-config
, geoipWithDatabase, gettext, gtk2, libxml2, minizip, pcre
, gslist, qstat, wget
}:

stdenv.mkDerivation rec {
  pname = "xqf";
  version = "2021-03-01";

  src = fetchFromGitHub {
    owner = "XQF";
    repo = pname;
    rev = "a04eab96f40f7ea011b9ae410fe49da26ea04b39";
    sha256 = "11ssilaiwpga318nyga4cd8bifwb3nj9l2v86a1idkn1kbqm52qh";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ geoipWithDatabase gettext gtk2 libxml2 minizip pcre ];
  propagatedBuildInputs = [ gslist qstat wget ];
  enableParallelBuilding = true;

  patches = [(pkgs.writeText "remove-tf-from-qstat-config.patch" ''
    XQF provides its own `qstat.cfg` except qstat 2.14 doesn't understand `TF`.
    --- ../src/qstat.cfg
    +++ ../src/qstat.cfg
    @@ -484,11 +484,6 @@
         master for gametype = ALIENARENAS
     end
     
    -gametype TF2 new extend TF
    -   name = Titanfall 2
    -   status packet = \x4d
    -end
    -
     # id Tech 2 fork (Quetoo engine, Quake 2 derivative)
     gametype QUETOOS new extend Q2S
         name = Quetoo
  '')];

  preBuild = ''
    mkdir build
    cd build
  '';

  buildPhase = ''
    cmake -DWITH_QSTAT=${qstat}/bin/qstat ..
    make
  '';

  meta = with lib; {
    homepage = "https://xqf.github.io/en/";
    description = "XQF is a game server browser and launcher for Unix/X11 for many popular games such as the Quake series, Unreal Tournament series, Half-Life etc.";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ drperceptron ];
  };
}
