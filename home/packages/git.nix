{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";

      user = {
        email = "heitor.guerra@proton.me";
        name = "Heitor Guerra";
      };

      core = {
        editor = "nano";
        pager = "more";
      };

      pull.rebase = false;
    };
  };
}
