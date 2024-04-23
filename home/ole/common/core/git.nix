{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Ole Tytlandsvik";
    userEmail = "ole.tytlandsvik@gmail.com";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}
