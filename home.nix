{inputs, config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "yuka";
    homeDirectory = "/home/yuka";

    packages = with pkgs; [
        # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        micro
        ani-cli
        discord
        vlc
        prismlauncher
        superTuxKart
        superTux
        extremetuxracer
        gimp-with-plugins
        python3
        krita
        libsForQt5.kdeconnect-kde
        opentabletdriver
        osu-lazer
        cura
        blender
        davinci-resolve
        protontricks
        tgpt
        protonup-qt
        obs-studio
        oneko
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
}
