{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # pkg-config
    # gnumake
    # gcc
    # cmake
  ];
}
