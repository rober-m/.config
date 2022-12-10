
{ config, pkgs, lib, ... }:
{
    programs.git = {
    enable = true;
    userName = "Robertino Martinez";
    userEmail = "48034748+rober-m@users.noreply.github.com";
    aliases = {
      s = "status";
      co = "checkout";
      aa = "add .";
      cm = "commit -m";
      ca = "commt --amend --no-edit";
    };
    difftastic.enable = true;
    extraConfig = {
      github.user = "rober-m";
      pull.rebase = false;
      merge.conflictstyle = "diff3";
      credential.helper = "osxkeychain";
    };
  };

}