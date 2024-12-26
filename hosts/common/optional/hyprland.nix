{ ... }:
{
  programs.hyprland = {
    enable = true;
  };

  # Wayland hint for electron apps
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = 1;
  };
}
