{
  description = "Dev Env for bluemngrs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    moz_overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, moz_overlay, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ moz_overlay.overlay ];
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            hyperfine
            rust-bin.stable.latest.default
            libclang
            clang
            bluez
          ];
          LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";
	  BINDGEN_EXTRA_CLANG_ARGS = 
          [
             ''-I"${pkgs.bluez.dev}/include"''
             ''$NIX_CFLAGS_COMPILE''
          ];
        };
      }
    ));
}
