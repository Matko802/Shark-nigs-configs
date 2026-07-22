{ pkgs, ... }:

{
  systemd.user.tmpfiles.rules = [
    "L+ %h/.local/share/color-schemes - - - - ${toString ./config}"
  ];
}