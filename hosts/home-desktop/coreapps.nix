
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs,lib,inputs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
   neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   git
   curl
   vulkan-tools
   clinfo
   firefox #web browser
   lynx #terminal based web browser
   htop #terminal based system monitor
   xorg.xeyes #used for wayland testing
   pamixer 
   mpv
   cartridges
   mkpasswd
   gnome.adwaita-icon-theme
   libsForQt5.sddm-kcm
   gnome-console
   evince
   gnome-text-editor
   gnome.seahorse
   gnome.gnome-disk-utility
   inputs.agenix.packages."${system}".default
  ];
    
  #Nonfree and web exposed apps should be wrapped in firejail
   programs.firejail = {
   enable = true;
   wrappedBinaries = {
   firefox = {
    executable = "${pkgs.firefox}/bin/firefox";
    profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
   };
  };
 };
 
 programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
}; 
programs.gamescope = {
  enable = true;
  #crashes when enabled unfortunately 
  #capSysNice = true;
  args = [
  "-W 3440"
  "-H 1440"
  "-r 100"
  "--adaptive-sync"
  #"--hdr-enabled"
  ];
};
programs.gamemode.enable = true;
}
