{
  rev,
  lib,
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

  meta = {
    description = "Launches Desktop Entries as Systemd user units";
    homepage = "https://github.com/Vladimir-csp/app2unit";
    license = lib.licenses.gpl3Only;
    mainProgram = "app2unit";
    platforms = lib.platforms.linux;
  };
}
