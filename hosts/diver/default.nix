# Diver: oceanbox laptop
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
    ../common/optional/blueman.nix # Bluetooth applet
    ../common/optional/regreet.nix # Login manager
    ../common/optional/power.nix # Power/battery stuff
    ../common/optional/tailscale.nix # VPN

    ################ Users to create  ################
    ../common/users/ole.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    initrd.luks.devices.luksroot = {
      device = "/dev/nvme0n1p1";
      preLVM = true;
      allowDiscards = true;
    };
    # FIXME: temporary fix to a bt bug: https://github.com/NixOS/nixpkgs/issues/521528
    kernelPackages = unstable-pkgs.linuxKernel.packages.linux_7_2;
  };

  networking.hostName = "diver";

  environment.sessionVariables = { };
  hardware.enableRedistributableFirmware = true;
}
