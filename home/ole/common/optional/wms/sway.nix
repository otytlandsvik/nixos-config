{ pkgs, lib, config, ... }: 
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

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      effect-blur = "7x5";
    };
  };

  # systemd.user.services.swaylock = {
  #   Unit.Description = "Lock Screen";
  #   Service.ExecStart = "${config.programs.swaylock.package}/bin/swaylock";
  # };

}
