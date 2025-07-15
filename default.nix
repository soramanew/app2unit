{
  rev,
  stdenvNoCC,
  makeWrapper,
  scdoc,
}:
stdenvNoCC.mkDerivation {
  pname = "app2unit";
  version = "${rev}";
  src = ./.;

  nativeBuildInputs = [makeWrapper];
  buildInputs = [scdoc];

  installPhase = "install -Dm755 app2unit $out/bin/app2unit";
}
