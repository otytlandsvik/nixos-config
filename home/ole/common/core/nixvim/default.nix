{ inputs, ... }: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;
    defaultEditor = true;

    clipboard.register = "unnamedplus"; # Use system clipboard

    colorschemes.tokyonight.enable = true;

    options = {
      relativenumber = true;
      # showcmd = true; # Show incomplete commands on bottom bar
      # showmode = true; # Show current mode on bottom bar
      autoread = true; # Reload files changed outside vim
      lazyredraw = true; # Redraw lazily
      # visualbell = true; # No sounds

      # Indentation
      # autoindent = true;
      # cindent = true; # Automatically indent braces
      # smartindent = true;
      # smarttab = true;
      shiftwidth = 2;
      # softtabstop = 2;
      # tabstop = 2;
      # expandtab = true;
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
          # fsautocomplete.enable = true;

          # Dockerfile
          # dockerls.enable = true;

          # js/ts
          tsserver.enable = true;

          # CSS
          # cssls.enable = true;

          # golang
          # gopls.enable = true;

          # C/C++
          ccls.enable = true;

          # Python
          pylsp.enable = true;

          # Typst
          # typst-lsp.enable = true;
        };
      };

      # Handy code snippets
      luasnip.enable = true;

      # Completion engine
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
	# snippet.expand = "luasnip";
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''
              function(fallback)
	        local luasnip = require('luasnip')
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end
            '';
            modes = [ "i" "s" ];
          };
        };
      };

      # Status bar
      # airline = {
      #   enable = true;
      #   powerline = true;
      # };
      lualine.enable = true;

      # Filetree viewer
      neo-tree =  {
        enable = true;
      };

      # File search
      telescope = {
        enable = true;
	      extensions.fzy-native.enable = true;
      };

      # Treesitter
      # treesitter.enable = true;

      # Display color code colors
      nvim-colorizer = {
        enable = true;
	      fileTypes = [ "*" ];
      };

      # Notification UI
      # fidget = {
      #   enable = true;
      #   text.spinner = "triangle";
      # };
    };

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
	key = "<leader>fg";
      }
    ];
  };
}
