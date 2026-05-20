{ lib, ... }:
{
  programs = {
    niri.enable = true;
    # Niri already starts an SSH agent (gnome-keyring)
    ssh.startAgent = lib.mkForce false;
  };

  # Wayland hint for electron apps
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = 1;
  };
}
