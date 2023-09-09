{config, pkgs, ... }:
#Home-Manager config.nix
{
 imports = [];


  home.username = "ben";
  home.homeDirectory = "/home/ben";
  
  home.packages = with pkgs; [
  evolution
  libreoffice-fresh
  hunspell
  hunspellDicts.en_GB-large
  warp
  bottles
  mpv
  calibre
  obsidian
  
  #spotify
  #discord
  ];
  
  programs.git = {
    enable = true;
    userName = "Ben Robertson";
    userEmail = "benrobertson150@hotmail.co.uk";
  };

  programs.bash = {
   enable = true;
   enableCompletion = true;
   shellAliases = {
   dev = "podman enter devprod";
   };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;


}
