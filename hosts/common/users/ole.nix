# Defualt config for user "ole"

{ pkgs, inputs, config, lib, ... }:
{
  users.users."ole" = {
    name = "ole";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "git" ];
    shell = pkgs.fish; # Default shell
    packages = [ pkgs.home-manager ];
  };

  # Import home configs
  # TODO: Allow hostname to be passed in for multiple home configs
  home-manager.users."ole" = import ../../../home/ole/home.nix;
}
