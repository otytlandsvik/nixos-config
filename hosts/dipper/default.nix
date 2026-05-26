# Dipper: work desktop
{ inputs, system, ... }:
let
  unstable-pkgs = import inputs.unstable { inherit system; };
in
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/niri.nix # Window manager
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
    # FIXME: temporary fix to a bt bug: https://github.com/NixOS/nixpkgs/issues/521528
    kernelPackages = unstable-pkgs.linuxPackages_latest;
  };

  networking.hostName = "dipper";

  services.hardware.bolt.enable = true;

  services.power-profiles-daemon.enable = true;

  environment.sessionVariables = { };
}
