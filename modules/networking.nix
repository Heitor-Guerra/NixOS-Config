{ vars, ... }:

{
  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;

  networking.nftables.enable = true;
}
