{ pkgs ? import <nixpkgs> {} }: with pkgs;

let qtOutput = x: if builtins.elem "bin" x.outputs then x.bin else x.out;
    makeQtPluginPath = lib.concatMapStringsSep ":" (x: "${qtOutput x}/${qt514.qtbase.qtPluginPrefix}");
    makeQmlImportPath = lib.concatMapStringsSep ":" (x: "${qtOutput x}/${qt514.qtbase.qtQmlPrefix}");
in mkShell {
  buildInputs = [ qt514.qtbase qt514.qtdeclarative kdeFrameworks.qqc2-desktop-style ];
  QT_PLUGIN_PATH = makeQtPluginPath [ qt514.qtbase qt514.qtquickcontrols2 kdeFrameworks.qqc2-desktop-style ];
  QML2_IMPORT_PATH = makeQmlImportPath [ qt514.qtdeclarative qt514.qtquickcontrols qt514.qtquickcontrols2 kdeFrameworks.qqc2-desktop-style ];
}
