{ pkgs, ... }:
{
  imports = [
    ./nix.nix # Nix settings
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Locale & timezone
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Keyboard layout and variant
  services.xserver.xkb = {
    layout = "us,no";
    variant = "altgr-intl,";
    options = "grp:win_space_toggle";
  };

  # Enable udev rule to flash new layouts to zsa keyboards
  hardware.keyboard.zsa.enable = true;

  # Enable firmware update service
  services.fwupd.enable = true;

  # Prevent out of memory
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeMemKillThreshold = 2;
  };

  ######## Core system packages ########
  environment.systemPackages = with pkgs; [
    wget
    firefox
    alacritty
    vim
    nh # Nix helpers utility
    qmk-udev-rules
  ];

  # Apply default config to packages exposing a module
  programs = {
    fish.enable = true; # Default shell
    git.enable = true;
    # Automatically start ssh agent on login
    ssh.startAgent = true;
  };

  # Enable docker
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  # Enable disk utilities
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Config was written using 23.11
  system.stateVersion = "23.11";
}
