{ pkgs, ... }:

{
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/mpv - - - - ${./config}"
  ];
}
