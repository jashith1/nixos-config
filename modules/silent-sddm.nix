{ config, pkgs, ... }:

{
  programs.silentSDDM = {
    enable = true;
    theme = "silvia";
    backgrounds = {steins_gate = ../wallpapers/steins_gate.mp4;};
    profileIcons = {bloppai = ../wallpapers/Araragi.jpeg;};
    settings = {
      "General" = {
        scale = 2.0;
      };
      "LockScreen" = {
        background = "steins_gate.mp4"; #when first boot (before typing in pw)
      };
      "LoginScreen" = {
        background = "steins_gate.mp4"; #when typing in password background
      };
      "LockScreen.Clock" = {
        color = "#c56829";
      };
      "LockScreen.Date" = {
        color = "#c56829";
      };
      "LockScreen.Message" = {
        display = true;
        text = "El. Psy. Kongroo.";
        color = "#c56829";
        display-icon = false;
      };
      "LoginScreen.LoginArea.Avatar" = {
        active-border-color = "#c56829";
        inactive-border-color = "#c56829";
      };
      "LoginScreen.LoginArea.Username" = {
        color = "#c56829";
      };
      "LoginScreen.LoginArea.PasswordInput" = {
        content-color = "#000000";
        background-color = "#d89123";
        border-color = "#c56829";
      };
      "LoginScreen.LoginArea.LoginButton" = {
        background-color = "#d89123";
        active-background-color = "#d89123";
        content-color = "#c56829";
        active-content-color = "#c56829";
        border-color = "#c56829";
      };
      "LoginScreen.LoginArea.Spinner" = {
        color = "#c56829";
      };
      "LoginScreen.LoginArea.WarningMessage" = {
        normal-color = "#c56829";
        warning-color = "#c56829";
        error-color = "#c56829";
      };
      "LoginScreen.MenuArea.Popups" = {
        background-color = "#c56829";
        active-option-background-color = "#c56829";
        border-color = "#c56829";
        content-color = "#000000";
        active-content-color = "#000000";
      };
      "LoginScreen.MenuArea.Session" = {
        background-color = "#c56829";
        content-color = "#000000";
        active-content-color = "#000000";
      };
      "LoginScreen.MenuArea.Layout" = {
        background-color = "#c56829";
        content-color = "#000000";
        active-content-color = "#000000";
      };
      "LoginScreen.MenuArea.Keyboard" = {
        background-color = "#c56829";
        content-color = "#000000";
        active-content-color = "#000000";
      };
      "LoginScreen.MenuArea.Power" = {
        background-color = "#c56829";
        content-color = "#000000";
        active-content-color = "#000000";
      };
      "LoginScreen.VirtualKeyboard" = { #doesnt seem to be working
        border-color = "#c56829";
        primary-color = "#d89123";
        selection-content-color = "#000000";
        key-color = "#000000";
      };
    };
  };
}
