# Enable fish on host level as backup
{
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "eza -l --icons";
      ll = "eza -al --icons";
      ls = "eza";
      lg = "lazygit";
    };
  };
}
