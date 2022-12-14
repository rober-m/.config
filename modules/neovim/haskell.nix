{ pkgs, inputs, system, ... }:


{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      {
        plugin = haskell-tools-nvim;
        type = "lua";
        config = ''
          ------------------------------------- HASKELL-TOOLS-NVIM -----------------------------------------
          -- Docs: https://github.com/MrcJkb/haskell-tools.nvim/
          -- This plugin automatically configures the haskell-language-server neovim client and integrateswith with other haskell tools.
          -- Do not call the lspconfig.hls setup or set up the lsp manually, as doing so may cause conflicts.

          local ht = require('haskell-tools')
          local on_attach = function(client, bufnr)

            -- enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- format on save
            vim.cmd [[autocmd bufwritepre * lua vim.lsp.buf.format()]]

            -- mappings.
            -- see `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap=true, silent=true, buffer=bufnr }

            require("which-key").register({
              ["gd"] = { vim.lsp.buf.declaration, "goto declaration"},
              ["gd"] = { vim.lsp.buf.definition, "goto definition"},
              ["K"] = { vim.lsp.buf.hover, "Hover"},
              ["gi"] = { vim.lsp.buf.implementation, "goto implementation"},
              ["gr"] = { vim.lsp.buf.references, "references"},
            })
            require("which-key").register({
                l = {
                  name = "lsp",
                  t = { vim.lsp.buf.type_definition, "type definition" },
                },
                h = {
                  name = "Haskell",
                  a = { vim.lsp.codelens.run, "CodeLens" },
                  h = { ht.hoogle.hoogle_signature, "Hoogle Signature" },
                },
                 
            }, { prefix = "<leader>" })

          end


          ht.setup {  -- LSP client options
            hls = {
              on_attach =  on_attach           
            },
          }

          ht.tools = { -- haskell-tools options
            repl = {
              -- 'builtin': Use the simple builtin repl
              -- 'toggleterm': Use akinsho/toggleterm.nvim
              handler = 'toggleterm',
              builtin = {
                create_repl_window = function(view)
                  -- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
                  return view.create_repl_split { size = vim.o.lines / 3 }
                end
              },
            },
          }

          require("which-key").register({
              h = {
                name = "Haskell",
                r = { 
                  name = "REPL",
                  t = {ht.repl.toggle, "Toggle" },
                  q = {ht.repl.quit, "Quit" },
                }
              },
               
          }, { prefix = "<leader>" })
          -----------------------------------------------------------------------------------------
        '';
      }
    ];

  };
}

