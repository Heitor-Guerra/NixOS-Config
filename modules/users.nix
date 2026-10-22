{ pkgs, vars, ... }:

{
  programs.${vars.shell}.enable = true;

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.${vars.shell};
  environment.localBinInPath = true;
  users.users.${vars.username} = {
    openssh.authorizedKeys.keys = [
      # add-key: "ssh-ed25519 AAAA..."
    ];
    isNormalUser = true;
    description = vars.username;
    extraGroups = vars.extraGroups;
    shell = pkgs.${vars.shell};
  };
}
