# Beiste: home desktop
{ pkgs, ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/sway.nix # Window manager
    ../common/optional/pipewire.nix # Sound config
    ../common/optional/regreet.nix # Login manager
    ../common/optional/blueman.nix # Bluetooth applet

    ################ Users to create  ################
    ../common/users/ole.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sdc";
    useOSProber = true;
  };

  networking.hostName = "beiste";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  environment.sessionVariables = {
    FLAKE = "~/nixos-config"; # Flake location for nh util
  };

  # For AMD GPU
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Steam setup for gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = [ pkgs.protonup ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
