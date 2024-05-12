{ inputs, pkgs, ... }: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./formatters.nix
  ];
  programs.nixvim = {
    enable = true;
    enableMan = true;
    defaultEditor = true;

    clipboard.register = "unnamedplus"; # Use system clipboard

    colorschemes.tokyonight.enable = true;

    options = {
      number = true; # Show actual line number instead of 0
      relativenumber = true; # Relative line numbers
      autoread = true; # Reload files changed outside vim
      lazyredraw = true; # Redraw lazily
      wrap = false; # Don't wrap lines by default

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
      luasnip = {
	enable = true;
	fromVscode = [
	  {}
	];
      };

      # Completion engine
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp_luasnip.enable = true;

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
	  "<Up>" = {
	      action = ''
	      function(fallback)
		if cmp.visible() then
		  cmp.select_prev_item()
		else
		  fallback()
		end
	      end
	    '';
	    modes = [ "i" "s"];
	    };
	  "<Down>" = {
	      action = ''
	      function(fallback)
		if cmp.visible() then
		  cmp.select_next_item()
		else
		  fallback()
		end
	      end
	    '';
	    modes = [ "i" "s"];
	    };
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

      # Show indentation lines and highlight scope
      indent-blankline = {
	enable = true;
	extraOptions.scope = {
	  show_start = false; # Disable scope start underline
	};
      };

      # Formatting
      conform-nvim = {
	enable = true;

	formattersByFt = {
	  nix = [ "nixfmt" ];
	  lua = [ "stylua" ];
	  python = [ "isort" "black" ];
	  javascript = [ "prettierd" ];
	  typescript = [ "prettierd" ];
	  javascriptreact = [ "prettierd" ];
	  typescriptreact = [ "prettierd" ];
	  css = [ "prettierd" ];
	  html = [ "prettierd" ];
	  json = [ "prettierd" ];
	  yaml = [ "prettierd" ];
	  markdown = [ "prettierd" ];
	  go = [ "goimports-reviser" "gofumpt" ];
	};
      };

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
	comment-nvim # Comment utilities
	friendly-snippets # Snippets for luasnip
        autoclose-nvim; # Automatically close braces
    };

    extraConfigLua = ''
      -- Timeout before keybind is triggered
      vim.opt.timeoutlen = 250

      -- Setup extra plugins
      require("Comment").setup()

      require("autoclose").setup({
        options = {
	  pair_spaces = true;
	}})

      -- Need to use extra conf to pass custom format function
      require("conform").setup({
	    format_on_save = function(bufnr)
	      -- Disable with a global or buffer-local variable
	      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
		return
	      end
	      return { timeout_ms = 500, lsp_fallback = true }
	    end,
	  })

      -- Define commands to enable/disable format on save
      -- from https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
      vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
	  -- FormatDisable! will disable only for current buffer
	  vim.b.disable_autoformat = true
	else
	  vim.g.disable_autoformat = true
	end
      end, {
	desc = "Disable autoformat on save",
	bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function(args)
	if args.bang then
	  -- FormatEnable! will enable only for current buffer
	  vim.b.disable_autoformat = false
	else
	  vim.g.disable_autoformat = false
	end
      end, {
	desc = "Enable autoformat on save",
	bang = true,
      })
      '';

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
      # Comment 
      {
	mode = [ "n" ];
	key = "<C-_>"; # Ctrl + /
	action = "gcc";
	options.remap = true; # Needed for recursive keymap
      }
      {
	mode = [ "v" ];
	key = "<C-_>";
	action = "gc";
	options.remap = true;
      }
      # Autoformat on save
      {
	key = "<leader>ad";
	action = "<cmd>FormatDisable<CR>";
	options.desc = "Disable autoformat on save globally";
      }
      {
	key = "<leader>aD";
	action = "<cmd>FormatDisable!<CR>";
	options.desc = "Disable autoformat on save for buffer";
      }
      {
	key = "<leader>ae";
	action = "<cmd>FormatEnable<CR>";
	options.desc = "Enable autoformat on save globally";
      }
      {
	key = "<leader>aE";
	action = "<cmd>FormatEnable!<CR>";
	options.desc = "Enable autoformat on save for buffer";
      }
    ];
  };
}
