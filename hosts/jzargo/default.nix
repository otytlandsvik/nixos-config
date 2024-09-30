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

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    initrd.luks.devices.luksroot = {
      device = "/dev/nvme0n1p1";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.hostName = "jzargo";
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
