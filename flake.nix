{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = {
    self,
    nixpkgs
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    devkitarm = (pkgs.callPackage ./devkitarm.nix {});
    includes = [
      "devkitARM"
      "devkitARM/arm-none-eabi"
      "libctru"
      "libgba"
      "libmirko"
      "libnds"
      "liborcus"
      "libtonc"
      "portlibs/3ds"
      "portlibs/armv4t"
      "portlibs/gba"
      "portlibs/gp2x"
      "portlibs/nds"
    ];
  in {
    devShells.${system}.default = pkgs.mkShell {
      DEVKITPRO="${devkitarm}/opt/devkitpro";
      DEVKITARM="${devkitarm}/opt/devkitpro/devkitARM";

      CPATH = pkgs.lib.makeSearchPath
        "include"
        (builtins.map (x: "${devkitarm}/opt/devkitpro/${x}") includes);

      LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";

      shellHook = ''
        export PATH="$PATH:${devkitarm}/opt/devkitpro/devkitARM/bin:${devkitarm}/opt/devkitpro/tools/bin"
      '';

      packages = [
        # 3DS setup
        pkgs.llvmPackages_11.libclang.lib
        devkitarm

        # Lang setup
        pkgs.clang-tools
      ];
    };
  };
}
