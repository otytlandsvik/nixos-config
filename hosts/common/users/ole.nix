# Defualt config for user "ole"

{ pkgs, ... }:
{
  users.users."ole" = {
    name = "ole";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "git"
    ];
    shell = pkgs.fish; # Default shell
    packages = [ pkgs.home-manager ]; # To bootstrap dotfiles
  };
}
