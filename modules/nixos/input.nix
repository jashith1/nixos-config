{ ... }:

{
  services.keyd = {
    enable = true;
    keyboards = {
      #matches only one (most restrictive) keyboard even though multiple would work
      #TODO look into some kinda alternative to avoid duplication
      default = {
        ids = [ "*" ];
        settings.main = {
          #overload allows og key + another key to act as og key making it better for shortcuts but theres noticable lag for singular taps
          #capslock = "overload(control, esc)";
          capslock = "esc";
        };
      };

      THkeyboard = {
        #60% keyboard
        ids = [ "258a:010c" ];
        settings.main = {
          esc = "grave";
          capslock = "esc";
        };
      };
    };
  };
}
