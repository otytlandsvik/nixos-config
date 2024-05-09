{ inputs, pkgs, ... }: {

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
      autoread = true; # Reload files changed outside vim
      lazyredraw = true; # Redraw lazily

      # Indentation
      # autoindent = true;
      cindent = true; # Automatically indent braces
      # smartindent = true;
      # smarttab = true;
      shiftwidth = 2;
      # softtabstop = 2;
      # tabstop = 2;
      # expandtab = true;
    };

    extraConfigLua = ''
      -- Timeout before keybind is triggered
      vim.opt.timeoutlen = 250

      -- Setup extra plugins
      require("autoclose").setup({
	  options = {
	    pair_spaces = true;
	  }})
      require("luasnip").setup({})
      '';

    # Set leader key to space
    globals.mapleader = " "; 

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
      # luasnip.enable = true;

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
      lualine.enable = true;

      # Bufferline (showing open buffers)
      bufferline = {
	enable = true;
	diagnostics = "nvim_lsp"; # Show lsp warnings
      };

      # Filetree viewer
      neo-tree =  {
        enable = true;
      };

      # File search
      telescope = {
        enable = true;
	extensions.fzy-native.enable = true;
	# NOTE: Keymaps are simply remapped to "<cmd>Telescope <action><CR>"
	keymaps = {
	  "<leader>ff" = {
	    desc = "Find files";
	    action = "find_files";
	  };
	  "<leader>fg" = {
	    desc = "Find with grep";
	    action = "live_grep";
	  };
	  "<leader>fb" = {
	    desc = "Find buffers";
	    action = "buffers";
	  };
	};
      };

      # Treesitter
      treesitter.enable = true;

      # Leader popup suggestions
      which-key.enable = true;

      # Display color code colors
      nvim-colorizer = {
        enable = true;
	      fileTypes = [ "*" ];
      };


      # Notification UI
      fidget = {
	enable = true;
	text.spinner = "triangle";
      };
    };

    # Plugins that aren't exposed through nixvim
    extraPlugins = builtins.attrValues {
    inherit (pkgs.vimPlugins)

      luasnip
      autoclose-nvim; # Automatically close brackets
    };

    # Keymaps
    keymaps = [
      # Neo-tree
      {
	key = "<leader>e";
	action = "<cmd>Neotree toggle<CR>";
	options.desc = "Toggle neo-tree";
      }
      # Buffers
      {
	mode = [ "n" ];
	key = "H";
	action = "<cmd>bprev<CR>";
      }
      {
	mode = [ "n" ];
	key = "L";
	action = "<cmd>bnext<CR>";
      }
      {
	key = "<leader>bd";
	action = "<cmd>bd<CR>";
	options.desc = "Delete current buffer";
      }
      # Windows
      {
        mode = [ "n" ];
	key = "<C-h>";
	action = "<C-w>h";
      }
      {
        mode = [ "n" ];
	key = "<C-j>";
	action = "<C-w>j";
      }
      {
        mode = [ "n" ];
	key = "<C-k>";
	action = "<C-w>k";
      }
      {
        mode = [ "n" ];
	key = "<C-l>";
	action = "<C-w>l";
      }
      {
	key = "<leader>wc";
	action = "<cmd>close<CR>";
	options.desc = "Close current window";
      }
      {
	key = "<leader>|";
	action = "<cmd>vsplit";
	options.desc = "Create new window, vertical split";
      }
      {
	key = "<leader>-";
	action = "<cmd>hsplit";
	options.desc = "Create new window, horizontal split";
      }
    ];

  };
}
