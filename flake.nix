{
  description = "lua-lean: LuaJIT scripts to Lean, with proofs; luajit is the reference interpreter its tests compare against";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let forAll = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (s: f nixpkgs.legacyPackages.${s});
    in {
      # flake.lock pins the LuaJIT version DESIGN.md names (`ref` in lua-lean)
      packages = forAll (pkgs: { default = pkgs.luajit; luajit = pkgs.luajit; });
      devShells = forAll (pkgs: { default = pkgs.mkShell { packages = [ pkgs.luajit pkgs.elan ]; }; });
    };
}
