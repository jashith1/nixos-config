{ ... }:

let
  defaultBrowser = "firefox.desktop";
in
{
  programs = {
    firefox.enable = true;
    chromium.enable = true;
  };

  home.sessionVariables.BROWSER = "firefox"; #for CLI tools that open links

  #links, html files and url schemes open in firefox
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ defaultBrowser ];
    "application/xhtml+xml" = [ defaultBrowser ];
    "x-scheme-handler/http" = [ defaultBrowser ];
    "x-scheme-handler/https" = [ defaultBrowser ];
    "x-scheme-handler/about" = [ defaultBrowser ];
    "x-scheme-handler/unknown" = [ defaultBrowser ];
  };
}
