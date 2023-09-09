
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{

  #Enable unfree software
  nixpkgs.config. allowUnfree = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ben = {
    isNormalUser = true;
    description = "ben";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #pkgs.lowPrio spotify
    #(pkgs.lowPrio discord)
    #  thunderbird
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
   neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   git
   curl
   vulkan-tools
   clinfo
   firefox
   lynx
   htop
   xorg.xeyes
  ];
    
  #Nonfree and web exposed apps should be wrapped in firejail
   programs.firejail = {
   enable = true;
   wrappedBinaries = {
   discord = {
   executable = "${pkgs.discord}/bin/discord";
   profile = "${pkgs.firejail}/etc/firejail/discord.profile";
   };
   spotify = {
    executable = "${pkgs.spotify}/bin/spotify";
    profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
   };
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


#Hardware enablement

hardware.opengl = {
driSupport = true;
extraPackages = with pkgs; [ rocm-opencl-icd ];
};



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
