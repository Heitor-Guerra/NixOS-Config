{ vars, ... }:

{
  networking.hostName = vars.hostname;
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.enable = true;

  networking.nftables.enable = true;
}
