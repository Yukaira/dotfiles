{inputs, config, pkgs, ... }:

{
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home = {
      username = "yuka";
      homeDirectory = "/home/yuka";

      packages = with pkgs; [
          ani-cli
          apktool
          audacity
          audacious
          #bambu-studio
          blender-hip
          bisq2
          davinci-resolve
          discord
          digikam
          extremetuxracer
          fastfetch
          ffmpeg
          firefox
          ghidra
          gimp
          handbrake
          inkscape
          kdePackages.kate
          kdePackages.kdeconnect-kde
          kdePackages.kdenlive
          krita
          micro
          (wrapOBS { 
          	plugins = with obs-studio-plugins; [
          		droidcam-obs
          		];
          	})
          obsidian
          oneko
          opentabletdriver
          osu-lazer
          picard
          piper
          prismlauncher
          protontricks
          protonup-qt
          python3
          resumed
          signal-desktop
          sl
          superTux
          superTuxKart
          #srb2kart
          termdown
          tor-browser-bundle-bin
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
   programs.starship.enable = true;
   programs.starship.settings = {
     add_newline = false;
     format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
     shlvl = {
       disabled = false;
       symbol = "ﰬ";
       style = "bright-red bold";
     };
     shell = {
       disabled = false;
       format = "$indicator";
       fish_indicator = "";
       bash_indicator = "[BASH](bright-white) ";
       zsh_indicator = "[zsh](bright-purple) ";
     };
     username = {
       style_user = "bright-white bold";
       style_root = "bright-red bold";
     };
     hostname = {
       style = "bright-green bold";
       ssh_only = true;
     };
     nix_shell = {
       symbol = "";
       format = "[$symbol$name]($style) ";
       style = "bright-purple bold";
     };
     git_commit = {
       only_detached = true;
       format = "[ﰖ$hash]($style) ";
       style = "bright-yellow bold";
     };
     git_state = {
       style = "bright-purple bold";
     };
     git_status = {
       style = "bright-green bold";
     };
     directory = {
       read_only = " ";
       truncation_length = 0;
     };
     cmd_duration = {
       format = "[$duration]($style) ";
       style = "bright-blue";
     };
     jobs = {
       style = "bright-green bold";
     };

  };
  
}
