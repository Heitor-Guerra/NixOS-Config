{ ... }:

{
  security.protectKernelImage = true;
  security.lockKernelModules = true;
  security.polkit.enable = true;
  security.sudo.execWheelOnly = true;
}
