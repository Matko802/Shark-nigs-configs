{ pkgs, ... }:

{
  systemd.user.tmpfiles.rules = [
    "L+ %h/.local/share/ - - - - ${./config}"
  ];
}
