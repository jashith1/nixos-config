{ ... }:

{
  programs = {
    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user = {
          name = "Jashith Raghavendra";
          email = "jashith.r1@gmail.com";
        };
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    #While I do use devenv+direnv sometimes, it gets very messy when there are multiple venvs active
    uv.enable = true;

    codex.enable = true;
    claude-code.enable = true;

    java.enable = true;
  };
}
