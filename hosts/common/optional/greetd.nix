# Greeter and display manager, to automatically go to
# window manager on boot

{ pkgs, ... }:

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
