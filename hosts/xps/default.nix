# XPS: Dell laptop
{ ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/sway.nix # Window manager
    ../common/optional/pipewire.nix # Sound config
    ../common/optional/blueman.nix # Bluetooth applet
    ../common/optional/regreet.nix # Login manager

    ################ Users to create  ################
    ../common/users/ole.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  networking.hostName = "xps";

  environment.sessionVariables = {
    FLAKE = "~/nixos-config"; # Flake location for nh util
  };
}
