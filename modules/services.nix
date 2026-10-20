{ vars, ... }:

{
  services.openssh = {
    enable = vars.enableOpenSSH;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  services.blueman.enable = true;
  services.fstrim.enable = vars.enableFstrim;

  virtualisation.docker = {
    enable = false;
    enableOnBoot = false;
    rootless = {
      enable = vars.enableDocker;
      setSocketVariable = true;
    };
    autoPrune = {
      enable = vars.dockerAutoPrune;
      allVolumes.enable = vars.dockerAutoPrune;
    };
  };

  services.journald.settings.Journal.SystemMaxUse = vars.journalMaxUse;
}
