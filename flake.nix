{

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {

      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";

    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixpkgs-fmt.enable = true;
      };
      pre-commit-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks.treefmt = {
          enable = true;
          package = treefmtEval.config.build.wrapper;
        };
      };
    in
    {

      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system} = {
        formatting = treefmtEval.config.build.check;
        pre-commit-check = pre-commit-check;
      };

      devShells.${system}.default = pkgs.mkShell {
        shellHook = ''
          ${pre-commit-check.shellHook}
        '';
      };

      nixosConfigurations.protogen-13 = inputs.nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                handbrake = prev.handbrake.overrideAttrs (oldAttrs: {
                  passthru = oldAttrs.passthru // {
                    ffmpeg-full = oldAttrs.passthru.ffmpeg-full.overrideAttrs (oldFFmpegAttrs: {
                      patches = (oldFFmpegAttrs.patches or [ ]) ++ [
                        # Fixes https://github.com/NixOS/nixpkgs/issues/484121
                        (final.fetchpatch2 {
                          url = "https://git.ffmpeg.org/gitweb/ffmpeg.git/patch/d8ffec5bf9a2803f55cc0822a97b7815f24bee83";
                          hash = "sha256-lmSI5arShb2/W84FMnSNs3lb6rd5vWdUSzfU8oza0Ic=";
                        })
                      ];
                    });
                  };
                });
              })
            ];
          })
        ];
      };

      homeConfigurations."yuka" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

    };

}
