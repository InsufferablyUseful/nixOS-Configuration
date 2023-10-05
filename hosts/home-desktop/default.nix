
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #Import apps that should be available to all users 
      ./coreapps.nix
      #Create desktop icons for wrapped binaries
      ./firejail-desktop-files.nix
      #Hyprland plus assorted utilities to build a complete environment
      ./hyprland.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot = {
  enable = true;
  extraEntries = {
  "grub.conf" = ''
  title Grub
  efi /efi/grub/x86_64-efi/grub.efi
  '';
  };
  };
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub.device = "/dev/sda";
  #boot.loader.grub.useOSProber = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # Use the xanmod kernel and related packages
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.extraModulePackages = with config.boot.kernelPackages; [xone];

  networking.hostName = "home-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  #Apply GTK themes to wayland apps
  programs.dconf.enable = true;  

  # Enable Hyprland window manager
  programs.hyprland.enable = true; 

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  #Enable xbox accessories support
  hardware.xone.enable = true;

  #Enable unfree software
  nixpkgs.config.allowUnfree = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users = {
   mutableUsers = false;
   users = {
	  ben = {
	    isNormalUser = true;
	    description = "ben";
	    extraGroups = [ "networkmanager" "wheel" ];
	    hashedPassword = "$6$RTgFw3ECvQmIUoHD$dCbRwNkzp5rTNApQmTSf2nF8r1AZWDq.oN01.Z2NhohaJ/NQgkmeTGBLE8DKDThDDPS5uRvh5OBAmbL2x8wOl0";
	    packages = with pkgs; [
	    #pkgs.lowPrio spotify
	    #(pkgs.lowPrio discord)
	    #  thunderbird
	    vlc
	    evolution
	    ];
	  };
	  steamUser = {
	    isNormalUser = true;
	    createHome = true;
	    description = "For running steam in gamescope";
	    extraGroups = [ "networkmanager" "wheel" ];
	    hashedPassword = "$6$9EELP2boX4.nMLNb$S9AJ2jIn4dxsZA8znPfmVfiE6oQt6ybiMqN2nUxnfbbWxghUm7tsEjxX1pmwJji0BVM60DZAVkLGUpvztw11p/";
	    packages = with pkgs; [
	    #pkgs.lowPrio spotify
	    #(pkgs.lowPrio discord)
	    #  thunderbird
	    steam
	    ];
	  };
   };
  };

  #Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal = {
  enable = true;
  extraPortals = (with pkgs;[xdg-desktop-portal-gnome]);
  };
  #Enable Samba
  services.gvfs.enable = true;
  
  #Enable Polkit
  security.polkit.enable = true;
  
  #Enable Gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
 # services.xserver.displayManager.autoLogin.user = "ben";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #Enable Wayland support for electron apps that support it
  environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  };
  
  environment.variables = {
  ENABLE_GAMESCOPE_WSI = "1";
  DXVK_HDR = "1";
  };
  
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  ]) ++ (with pkgs.gnome;[
  epiphany
  geary
  totem
  ]);
  
  services.getty = {
  autologinUser = "steamUser";
  extraArgs = ["--noclear" "tty3"];
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
driSupport32Bit = true;
extraPackages = with pkgs; [ rocm-opencl-icd ];
};

fileSystems."/run/media/ben/LinuxPCISSD" =
  { device = "/dev/disk/by-uuid/6c7c3ac0-178f-49b1-8247-43b96283409c";
    options = ["nofail"];
  };
  
fileSystems."/run/media/ben/LinuxGamingPrimary" =
  { device = "/dev/disk/by-uuid/6a8b09df-4658-48fa-859f-315c0eea3994";
    options = ["nofail"];
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
