unprofessional dotfiles

(re) installation instructions
    Clone the repository `git clone https://github.com/Yukaira/dotfiles`
    Move your Hardware.conf into ~/dotfiles
    Rebuild Nix `sudo nixos-rebuild switch --flake path:`
    Initialize Home-manager `nix run home-manager/release-24.05 -- init --switch` (Make sure home-manger version matches the nixpkgs version you're using)
    Build home-manager `home-manager switch --flake .`
    (Optional) Update flake `nix flake update` and rebuild once more
    Reboot
