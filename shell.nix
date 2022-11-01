{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  opencvGtk = opencv.override (old : { enableGtk2 = true; });
  mypython = python38.withPackages (python-pkgs: with python-pkgs; [ (opencv4.override (old : { enableGtk2 = true; })) jupyter scipy ]);
in
mkShell {
  buildInputs = [
      mypython
      opencvGtk
  ];

  shellHook = ''
    PYTHONPATH=${mypython}/${mypython.sitePackages}
  '';
}
