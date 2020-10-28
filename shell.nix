{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
  buildInputs = [ qt514.qtbase qt514.qtdeclarative ];
}
