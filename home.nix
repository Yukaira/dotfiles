{inputs, config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "yuka";
    homeDirectory = "/home/yuka";

    packages = with pkgs; [
        # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        ani-cli
        blender
        cura
        davinci-resolve
        discord
        extremetuxracer
        gimp-with-plugins
        handbrake
        krita
        libsForQt5.kdeconnect-kde
        micro
        neofetch
        obs-studio
        oneko
        opentabletdriver
        osu-lazer
        prismlauncher
        protontricks
        protonup-qt
        python3
        sl
        superTux
        superTuxKart
        termdown
        tgpt
        tldr
        vesktop
        vlc
    ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.
  };
    nixpkgs.config.allowUnfreePredicate = _: true;
    programs.git.enable = true;

   #enable zoxide 
   programs.zoxide.enable = true;
   programs.zoxide.enableBashIntegration = true;
   programs.fzf.enable = true;

   #enable zsh
   programs.zsh = {
     enable = true;
     enableCompletion = true;
     autosuggestion.enable = true;
     syntaxHighlighting.enable = true;

     oh-my-zsh = {
         enable = true;
         plugins = [ "git" "thefuck" ];
         theme = "af-magic";
       };
 
     shellAliases = {
       ll = "ls -l";
       update = "sudo nixos-rebuild switch";
     };
     history.size = 10000;
     history.path = "${config.xdg.dataHome}/zsh/history";
   };

}
