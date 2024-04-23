{ inputs, pkgs, ... }: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    colorschemes.gruvbox.enable = true;

    options = {
      relativenumber = true;
    };
  };

}
