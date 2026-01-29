{
        
  inputs = {
        
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        
    home-manager = {
        
      url = "github:nix-community/home-manager";
        
      inputs.nixpkgs.follows = "nixpkgs";
        
    };
        
  };
        
  outputs = inputs: {
        
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
                      patches = (oldFFmpegAttrs.patches or []) ++ [
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
