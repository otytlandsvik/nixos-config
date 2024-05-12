{ pkgs, ... }:
{
  # Code formatters
  home.packages = with pkgs; [
    nixfmt
    prettierd
    stylua
    isort
    black
    goimports-reviser
    gofumpt
  ];
}
