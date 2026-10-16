{ vars, ... }:

{
  i18n.defaultLocale = vars.defaultLocale;
  console.keyMap = vars.consoleKeymap;
  time.timeZone = vars.timezone;
  services.xserver.xkb = {
    layout = vars.xkbLayout;
    variant = vars.xkbVariant;
  };
}
