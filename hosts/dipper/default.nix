# Dipper: work desktop
{ ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/hyprland.nix # Window manager
    ../common/optional/pipewire.nix # Sound config
    ../common/optional/regreet.nix # Login manager
    ../common/optional/blueman.nix # Bluetooth applet
    ../common/optional/openssh.nix # SSH Daemon
    ../common/optional/nix-ld.nix # Dynamic library patcher
    ../common/optional/tailscale.nix # VPN
    ../common/optional/logitech.nix # Logitech peripherals software

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

  # DNS masking for Atlantis
  services.dnsmasq = {
    enable = true;
    settings.address = [
      "/.local/127.0.0.1"
      "/.local.oceanbox.io/127.0.0.1"
    ];
  };

  networking.hostName = "dipper";

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  environment.sessionVariables = { };
}
