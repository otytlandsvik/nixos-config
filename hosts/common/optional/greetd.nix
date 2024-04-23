# Greeter and display manager, to automatically go to
# window manager on boot

{ config, pkgs, lib, ... }:

{
  config = {
    services.greetd = {
      enable = true;
      restart = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --cmd sway";
          user = "ole";
        };
      };
    };
  };
}
