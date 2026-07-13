{ pkgs, ... }:

{
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/kitty - - - - ${./config}"
  ];
}
