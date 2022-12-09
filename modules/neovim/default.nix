{ config, pkgs, lib, ... }:
{

  #################### CONFIG INSPIRED BY: #########################

  # https://github.com/srid/nixos-config/blob/master/home/neovim.nix

  ##################################################################

  imports = [
    ./telescope.nix
    # ./neovim/coc.nix
    # ./neovim/haskell.nix
    # ./neovim/rust.nix
    # ./neovim/zk.nix
    # which-key must be the last import for it to recognize the keybindings of
    # previous imports.
    ./which-key.nix
  ];
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # Add NodeJs since it's required by some plugins I use.
    withNodeJs = true;

  # Full list here:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix
  plugins = with pkgs.vimPlugins; [
    # Themes 
    sonokai
    dracula-vim
    gruvbox
    papercolor-theme
    tokyonight-nvim
    {
        plugin = lazygit-nvim;
        type = "lua";
        config = ''
          nmap("<leader>gg", ":LazyGit<cr>")
        '';
      }

    # Apperance, interface, UI, etc.
    bufferline-nvim
    galaxyline-nvim 
    gitsigns-nvim
    indent-blankline-nvim

    # { plugin = toggleterm-nvim; config = ""; }

    # # Completions
    # copilot-vim

    # # Language servers, linters, etc.
    # {
    #   plugin = lsp_lines-nvim;
    #   config = ''
    #     require'lsp_lines'.setup()
    #     vim.diagnostic.config({ virtual_lines = { only_current_line = true } })'';
    # }
    # { plugin = lspsaga-nvim; config = ""; }
    # { plugin = null-ls-nvim; config = ""; }
    # { plugin = nvim-lspconfig; config = ""; }

    nvim-treesitter.withAllGrammars
    vim-haskell-module-name
    vim-polyglot

    # # Editor behavior
    # { plugin = comment-nvim; config = "require'comment'.setup()"; }
    # { plugin = editorconfig-vim; setup = "vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }"; }
    # { plugin = tabular; vscode = true; }
    # { plugin = vim-surround; vscode = true; }
    # { plugin = nvim-lastplace; config = "require'nvim-lastplace'.setup()"; }
    # {
    #   use = vim-pencil;
    #   setup = "vim.g['pencil#wrapModeDefault'] = 'soft'";
    #   config = "vim.fn['pencil#init'](); vim.wo.spell = true";
    #   ft = [ "markdown" "text" ];
    # }

    # # Misc
    # { use = direnv-vim; }
    # { use = vim-eunuch; vscode = true; }
    # { use = vim-fugitive; }
  ];

  # Required packages -------------------------------------------------------------------------- {{{
  extraPackages = with pkgs; [
    #neovim-remote
    lazygit

    # Language servers, linters, etc.
    # See `../configs/nvim/lua/malo/nvim-lspconfig.lua` and
    # `../configs/nvim/lua/malo/null-ls-nvim.lua` for configuration.
    
    # Haskell
    # TODO

    # Bash
    nodePackages.bash-language-server
    shellcheck

    # Javascript/Typescript
    nodePackages.typescript-language-server

    # Nix
    deadnix
    statix
    nil
    nixpkgs-fmt

    # Vim
    nodePackages.vim-language-server

    #Other
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    proselint
    sumneko-lua-language-server
  ];

  extraConfig = ''
      lua << EOF
      ${builtins.readFile ./neovim.lua}
      EOF
    '';

  };
}