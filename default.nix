{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let deps = [ (texlive.combine { inherit (texlive) scheme-basic hyperref geometry; }) ];
in
  if lib.inNixShell
  then
    mkShell {
      nativeBuildInputs = deps;
    }
  else
    stdenv.mkDerivation {
      name = "resume";
      src = ./.;
      buildInputs = deps;
      buildPhase = ''
        mkdir -p $out
        HOME=./. pdflatex resume.tex
        cp resume.pdf $out
      '';
      installPhase = ''
        echo done
      '';
    }
