
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

  let
  discordDesktopIcon = pkgs.makeDesktopItem {
    name = "discord";
    icon = "${pkgs.discord}/opt/Discord/discord.png";
    desktopName = "Discord";
    exec = "firejail ${pkgs.discord}/bin/discord --profile ${pkgs.firejail}/etc/firejail/discord.profile";
    terminal = false;
    };
  spotifyDesktopIcon = pkgs.makeDesktopItem {
    name = "spotify";
    desktopName = "Spotify";
    icon = "${pkgs.spotify}/share/icons/hicolor/512x512/apps/spotify-client.png";
    exec = "firejail ${pkgs.spotify}/bin/spotify --profile ${pkgs.firejail}/etc/firejail/spotify.profile";
    terminal = false;
  };
  in {
  environment.systemPackages = with pkgs; [discordDesktopIcon spotifyDesktopIcon];
  }
