{ vars, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = vars.systemPackages;
}
