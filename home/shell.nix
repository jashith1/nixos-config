{ ... }:

{
  programs = {
    bash.enable = true;
    #starship.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
        style = "plain";
      };
    };

    zoxide.enable = true;
  };
}
