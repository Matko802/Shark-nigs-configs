{ pkgs, ... }:

{
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fastfetch - - - - ${toString ./config}"
  ];
}