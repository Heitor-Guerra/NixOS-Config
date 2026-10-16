{ pkgs, vars, ... }:

{
  programs.${vars.shell}.enable = true;

  users.defaultUserShell = pkgs.${vars.shell};
  environment.localBinInPath = true;
  users.users.${vars.username} = {
    openssh.authorizedKeys.keys = [
      # add-key: "ssh-ed25519 AAAA..."
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE971Fu8XInwv2jLpU4FjQKwieHq16fjI+mnyX+vMi/p Heitor-Guerra@Laptop-Heitor"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIa3M0svIL6zMRNOmPKXsNIVxB86KqHI2R8pFkDY+Y6u heitor@padufes-01"
    ];
    isNormalUser = true;
    description = vars.username;
    extraGroups = vars.extraGroups;
    shell = pkgs.${vars.shell};
  };
}
