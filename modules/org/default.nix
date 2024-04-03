{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.org.neorg;
in {
  options.vim.org.neorg = {
    enable = mkEnableOption "neorg";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = ["neorg" "lua-utils"];

    vim.luaConfigRC.chat =
      nvim.dag.entryAnywhere
      /*
      lua
      */
      ''
        require('neorg').setup {
            -- Tell Neorg what modules to load
            load = {
              ["core.defaults"] = {}, -- Load all the default modules
              ["core.keybinds"] = {
                config = {
                  default_keybinds = true,
                  norg_leader = "<leader>o"
                }
              }, -- Load keybinds
              ["core.norg.concealer"] = {}, -- Allows for use of icons
              ["core.norg.dirman"] = { -- Manage your directories with Neorg
              config = {
                workspaces = {
                  my_workspace = "~/Documents/notes"
                }
              }
            }
          },
        }
      '';
  };
}
