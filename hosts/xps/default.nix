# XPS: Dell laptop
{ ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/hyprland.nix # Window manager
    ../common/optional/pipewire.nix # Sound config
    ../common/optional/blueman.nix # Bluetooth applet
    ../common/optional/regreet.nix # Login manager
    ../common/optional/power.nix # Power/battery stuff
    ../common/optional/tailscale.nix # VPN

    ################ Users to create  ################
    ../common/users/ole.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  networking.hostName = "xps";

  environment.sessionVariables = { };
}
