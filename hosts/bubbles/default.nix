# Bubbles: slow desktop at uni
{ pkgs, ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/sway.nix # Window manager
    ../common/optional/pipewire.nix # Sound config
    # ../common/optional/greetd.nix # Display manager

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

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    alacritty
  ];

  system.stateVersion = "23.11";
}
