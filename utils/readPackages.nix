{ pkgs, lib, package-file-path, ... }:
with builtins;
with lib;

let
  packageFile = fromTOML (readFile package-file-path);
  getNestedAttr = foldl' (state: arg: state.${arg} or null);

  asPackage = p:
    let package = getNestedAttr pkgs (splitString "." p);
    in if package == null then
      throw
        "Could not unpack `pkgs.${p}` declared in a TOML file, pkgs doesn't have that attribute."
    else
      package;

in
mapAttrs (key: value: map asPackage value) packageFile
