{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix # Nix settings
    ./fish.nix # Default shell
  ];

  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

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

  # Login manager
  programs.regreet.enable = true;
}
