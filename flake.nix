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
        
      modules = [ ./configuration.nix ./hardware-configuration.nix ];
        
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
