{ inputs, ... }: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    clipboard.register = "unnamedplus"; # Use system clipboard

    colorschemes.tokyonight.enable = true;

    options = {
      relativenumber = true;
      showcmd = true; # Show incomplete commands on bottom bar
      showmode = true; # Show current mode on bottom bar
      autoread = true; # Reload files changed outside vim
      lazyredraw = true; # Redraw lazily
    };

    globals.mapleader = " "; # Set leader key to space

    ############### Plugins ###############
    plugins = {
      
      # Language service providers
      lsp = {
        enable = true;
	servers = {
	  # Nix
	  nil_ls.enable = true;

	  # F#
	  fsautocomplete.enable = true;

	  # Dockerfile
	  # dockerls.enable = true;

	  # js/ts
	  tsserver.enable = true;

	  # CSS
	  cssls.enable = true;

	  # golang
	  gopls.enable = true;

	  # C/C++
	  ccls.enable = true;

	  # Python
	  pylsp.enable = true;

	  # Typst
	  typst-lsp.enable = true;
	};
      };

      # Filetree viewer
      neo-tree =  {
        enable = true;
      };

      # Completion engine
      nvim-cmp = {
        enable = true;
	autoEnableSources = true;
	sources = [
	  {name = "nvim_lsp";}
	  {name = "path";}
	  {name = "buffer";}
	];
      };

    };

  };

}
