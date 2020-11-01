{ pkgs ? import <nixpkgs> {} }: with pkgs; with pkgs.qt514; with kdeFrameworks;

let qtOutput = x: if builtins.elem "bin" x.outputs then x.bin else x.out;
    makeQtPluginPath = lib.concatMapStringsSep ":" (x: "${qtOutput x}/${qtbase.qtPluginPrefix}");
    makeQmlImportPath = lib.concatMapStringsSep ":" (x: "${qtOutput x}/${qtbase.qtQmlPrefix}");
in mkShell {
  buildInputs = [ qtbase qtdeclarative qqc2-desktop-style ];
  QT_PLUGIN_PATH = makeQtPluginPath [ qtbase qtquickcontrols2 qqc2-desktop-style kirigami2 ];
  QML2_IMPORT_PATH = makeQmlImportPath [ qtdeclarative qtquickcontrols qtquickcontrols2 qqc2-desktop-style kirigami2 ];
}
