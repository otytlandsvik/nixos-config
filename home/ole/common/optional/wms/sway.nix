{ pkgs, lib, ... }: 
{
# NOTE: Sway may already be enabled from /hosts/ config

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
    };
  };

}
