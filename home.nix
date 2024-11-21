{inputs, config, pkgs, ... }:

{
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home = {
      username = "yuka";
      homeDirectory = "/home/yuka";

      packages = with pkgs; [
          ani-cli
          audacity
          blender
          #cura
          davinci-resolve
          discord
          extremetuxracer
          gimp-with-plugins
          handbrake
          resumed
          krita
          kdePackages.kdeconnect-kde
          micro
          neofetch
          obs-studio
          obsidian
          oneko
          opentabletdriver
          osu-lazer
          prismlauncher
          piper
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
          yt-dlp
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

    # Enable Zoxide
    programs.zoxide.enable = true;
    programs.fzf.enable = true;

    # Enable Zsh
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
    };

    # Set environment variables
    home.sessionVariables = {
      EDITOR = "micro";
      BROWSER = "firefox";
      TERMINAL = "kitty";
  };
    # Configure kitty terminal
    programs.kitty = {

    # Enable kitty
    enable = true;

    # Define kitty settings
    settings = {
     scrollback_lines = 10000;
     enable_audio_bell = false;
     update_check_interval = 0;
     background_opacity = "0.25";
     dynamic_background_opacity = true; 
     background_image_layout = "centered";
     background_image = "~/xenia.png";
     background_blur = 1;
    };

    # Configure font
    font = {
      name = "3270 Nerd Font";
      size = 8;
    };

  };
    # Enable & Configure Starship
    programs.starship =
     let
       flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
     in
     {
       enable = true;
       settings = {
         # Other config here
         format = "$all"; # Remove this line to disable the default prompt format
         palette = "catppuccin_${flavour}";
       } // builtins.fromTOML (builtins.readFile
         (pkgs.fetchFromGitHub
           {
             owner = "catppuccin";
             repo = "starship";
             rev = "5629d23"; # Replace with the latest commit hash
             sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
           } + /palettes/${flavour}.toml));
     };

}
