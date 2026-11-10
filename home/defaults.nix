# Default applications (MIME handlers, $BROWSER).
{ ... }:

let
  browser = "firefox.desktop";
  fileManager = "org.gnome.Nautilus.desktop";
in
{
  home.sessionVariables.BROWSER = "firefox"; #for CLI tools that open links

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      #links, html files and url schemes open in firefox
      "text/html" = [ browser ];
      "application/xhtml+xml" = [ browser ];
      "x-scheme-handler/http" = [ browser ];
      "x-scheme-handler/https" = [ browser ];
      "x-scheme-handler/about" = [ browser ];
      "x-scheme-handler/unknown" = [ browser ];

      "application/zip" = [ fileManager ];
    };
  };
}
