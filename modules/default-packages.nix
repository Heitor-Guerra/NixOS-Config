{ vars, ... }:

{
  environment.systemPackages = vars.systemPackages;

  programs.steam.enable = vars.enableSteam;
}
