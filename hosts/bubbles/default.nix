# Bubbles: slow desktop at uni
{ ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/sway.nix # Window manager
    ../common/optional/pipewire.nix # Sound config

    ################ Users to create  ################
    ../common/users/ole.nix
  ];

  # Use systemd for linux-only machine
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  networking.hostName = "bubbles";
}
