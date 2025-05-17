unprofessional dotfiles

***cheatsheet***

refresh KDE icons when they disappear
 
     sed -i 's/file:\/\/\/nix\/store\/[^\/]*\/share\/applications\//applications:/gi' \
        ~/.config/plasma-org.kde.plasma.desktop-appletsrc \
        && systemctl restart --user plasma-plasmashell

*rebuilds*
   
   home-manager
   
      home-manager `home-manager switch --flake .
   note that that must be run as your user, and you must be in the folder where your dotfiles are.
   
   nix rebuild

      sudo nixos-rebuild switch --flake . 
   note that you must be in the folder where your dotfiles are

***(re) installation instructions***
   
  Clone the repository `git clone https://github.com/Yukaira/dotfiles`

  Move your Hardware.conf into ~/dotfiles
  
  Rebuild Nix `sudo nixos-rebuild switch --flake path:`
  
  Initialize Home-manager `nix run home-manager/release-24.05 -- init --switch` (Make sure home-manger version matches the nixpkgs version you're using)
  
  Build home-manager `home-manager switch --flake .`
  
  (Optional) Update flake `nix flake update` and rebuild once more
  
  Reboot
