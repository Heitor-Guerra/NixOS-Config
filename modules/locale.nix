{ vars, ... }:

{
  i18n.defaultLocale = vars.defaultLocale;
  console.keyMap = vars.consoleKeymap;

  services.xserver.xkb = {
    layout = vars.xkbLayout;
    variant = vars.xkbVariant;
  };
}
