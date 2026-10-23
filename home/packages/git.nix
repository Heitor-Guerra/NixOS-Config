{ ... }:

{
  programs = {
    git = {
      enable = true;

      settings = {
        init.defaultBranch = "main";

        user = {
          email = "heitor.guerra@proton.me";
          name = "Heitor Guerra";
        };

        core = {
          editor = "nvim";
          pager = "less -FRX";
        };

        pull.rebase = false;
        push.autoSetupRemote = true;
      };
    };

    difftastic = {
      enable = true;
      git = {
        enable = true;
        mode = "both";
      };
      options = {
        color = "always";
        sort-paths = true;
        tab-width = 8;
      };
    };
  };
}
