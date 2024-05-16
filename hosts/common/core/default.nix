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

  ######## Core system packages ########
  environment.systemPackages = with pkgs; [
    wget
    firefox
    alacritty
    vim
    nh # Nix helpers utility
  ];

  # Apply default config to packages exposing a module
  programs = {
    fish.enable = true; # Default shell
    git.enable = true;
  };

  # Config was written using 23.11
  system.stateVersion = "23.11";
}
