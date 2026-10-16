{ vars, ... }:

{
  boot.kernelPackages = vars.kernelPackages;
  boot.kernelParams = vars.kernelParams;
}
