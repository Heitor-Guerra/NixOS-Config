{ vars, ... }:

{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "services/net.local.foot.desktop"._launch = "Ctrl+Alt+T";
      "services/org.kde.spectacle.desktop"._launch = "Print";
    };
    configFile = {
      baloofilerc.General.dbVersion = 2;
      kcminputrc.Mouse.cursorSize = 18;
      kded5rc.Module-browserintegrationreminder.autoload = false;
      kded5rc.Module-device_automounter.autoload = true;
      kdeglobals.General.TerminalApplication = "foot";
      kdeglobals.General.TerminalService = "foot.desktop";
      kdeglobals.General.UseSystemBell = true;
      kdeglobals.Icons.Theme = "breeze-dark";
      kdeglobals.KDE.AnimationDurationFactor = 0.7;
      kdeglobals.KDE.contrast = 4;
      kdeglobals.KDE.frameContrast = 0.2;
      kdeglobals.Locale.BinaryUnitDialect = 2;
      kdeglobals.PreviewSettings.EnableRemoteFolderThumbnail = false;
      kdeglobals.PreviewSettings.MaximumRemoteSize = 0;
      kdeglobals.WM.activeBackground = "39,44,49";
      kdeglobals.WM.activeBlend = "252,252,252";
      kdeglobals.WM.activeForeground = "252,252,252";
      kdeglobals.WM.inactiveBackground = "32,36,40";
      kdeglobals.WM.inactiveBlend = "161,169,177";
      kdeglobals.WM.inactiveForeground = "161,169,177";
      kiorc.Confirmations.ConfirmDelete = true;
      kiorc.Confirmations.ConfirmEmptyTrash = false;
      kiorc.Confirmations.ConfirmTrash = false;
      kiorc."Executable scripts".behaviourOnLaunch = "alwaysAsk";
      krunnerrc.Plugins.baloosearchEnabled = false;
      krunnerrc.Plugins.calculatorEnabled = true;
      krunnerrc.Plugins.helprunnerEnabled = false;
      krunnerrc.Plugins.krunner_appstreamEnabled = false;
      krunnerrc.Plugins.krunner_bookmarksrunnerEnabled = false;
      krunnerrc.Plugins.krunner_killEnabled = true;
      krunnerrc.Plugins.krunner_kwinEnabled = false;
      krunnerrc.Plugins.krunner_plasma-desktopEnabled = false;
      krunnerrc."Plugins/Favorites".plugins = "krunner_sessions,krunner_powerdevil,krunner_services,krunner_systemsettings";
      kscreenlockerrc."Greeter/Wallpaper/org.kde.image/General".Image = "file:///home/${vars.username}/Pictures/Imagens/Tela_Padrao.jpg";
      kscreenlockerrc."Greeter/Wallpaper/org.kde.image/General".PreviewImage = "file:///home/${vars.username}/Pictures/Imagens/Tela_Padrao.jpg";
      ksplashrc.KSplash.Theme = "a2n.kuro";
      kwalletrc.Wallet."First Use" = false;
      kwinrc.Desktops.Id_1 = "aecfa47f-bf02-4294-8f07-5f74feec3a57";
      kwinrc.Desktops.Number = 1;
      kwinrc.Desktops.Rows = 1;
      kwinrc.Plugins.magiclampEnabled = true;
      kwinrc.Plugins.squashEnabled = false;
      kwinrc.Xwayland.Scale = 1;
      kwinrulesrc.General.rules = "";
      kxkbrc.Layout.LayoutList = "br";
      kxkbrc.Layout.Model = "abnt2";
      kxkbrc.Layout.Use = true;
      plasma-localerc.Formats.LANG = "pt_BR.UTF-8";
      plasmanotifyrc."Applications/firefox".Seen = true;
      plasmarc.Wallpapers.usersWallpapers = "/home/${vars.username}/Pictures/Imagens/Tela_Padrao.jpg";
      spectaclerc.Annotations.annotationToolType = 7;
    };
    dataFile = {

    };
  };
}
