{ ... }:

{
  time = {
    hardwareClockInLocalTime = true; #usually dualbooting
    timeZone = "America/Chicago";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_ALL = "en_US.UTF-8";
  };
}
