{ vars, ... }:

{
  services.openssh = {
    enable = vars.enableOpenSSH;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  services.fstrim.enable = vars.enableFstrim;

  virtualisation.docker = {
    enable = vars.enableDocker;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    autoPrune = {
        enable = vars.dockerAutoPrune;
        allVolumes.enable = vars.dockerAutoPrune;
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=${vars.journalMaxUse}
  '';

  programs.nix-ld.enable = true;
}
