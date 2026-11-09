{ ... }:

{
  programs = {
    vim.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      sideloadInitLua = true; #tells hm that I have my own nvim config
    };
  };
}
