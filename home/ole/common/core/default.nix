{ config, lib, pkgs, ... }:
{
  imports = [
    # Packages with custom configs
    ./git.nix
    ./nixvim
    ./fonts.nix
  ]; # ++ (builtins.attrValues outputs.homeManagerModules);

  # Let home manager install and manage itself
  programs.home-manager.enable = true;

  # Home manager configuration
  home = {
    username = lib.mkDefault "ole";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    sessionVariables = {
      SHELL = "fish";
      TERM = "alacritty";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
    };
  };

  # Packages without custom configs
  home.packages = builtins.attrValues {
    inherit (pkgs)
      
      eza # ls replacement
      fzf # Fuzzy find
      lazygit # git GUI for the terminal
      ripgrep # grep goodness
      pfetch; # System info
  };

}
