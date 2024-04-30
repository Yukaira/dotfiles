{
        
  inputs = {
        
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        
    home-manager = {
        
      url = "github:nix-community/home-manager";
        
      inputs.nixpkgs.follows = "nixpkgs";
        
    };
        
  };
        
  outputs = inputs: {
        
    nixosConfigurations.protogen-9 = inputs.nixpkgs.lib.nixosSystem { 
        
      system = "x86_64-linux";
        
      modules = [ ./configuration.nix ./hardware-configuration.nix ];
        
    };
        
  };
        
}
