{ vars, ... }:

{
  security.sudo.enable = vars.enableSudo;

  security.protectKernelImage = true;
}
