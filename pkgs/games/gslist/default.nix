{ stdenv, fetchurl, lib
, unzip
, geoipWithDatabase, libmysqlclient, mysql-client, zlib
}:

stdenv.mkDerivation rec {
  pname = "gslist";
  version = "0.8.11a";

  src = fetchurl {
    url = "https://aluigi.altervista.org/papers/gslist.zip";
    sha256 = "0d1hqs7lbxr4gscxqsg51jlblpvxc1yap06bqzjvcljvmvn2mkba";
  };

  nativeBuildInputs = [ unzip ];
  buildInputs = [ geoipWithDatabase zlib ];
  propagatedBuildInputs = [ libmysqlclient mysql-client ];
  enableParallelBuilding = true;

  unpackPhase = ''
    unzip $src
  '';

  buildPhase = ''
    make clean # Removes binaries included in the distribution
    make
  '';

  makeFlags = [ "PREFIX=$(out)" ];

  postInstall = ''
    mkdir $out/etc
    cp gslist.cfg $out/etc

    mkdir -p $out/share/doc/${pname}
    cp gpl.txt gslist.txt $out/share/doc/${pname}
  '';

  meta = with lib; {
    homepage = "https://aluigi.altervista.org/papers.htm#gslist";
    description = "Gslist is a game servers browser supporting an incredible amount of games (over 4000) for many different platforms like PC, Wii, Playstation and more";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ drperceptron ];
  };
}
