{ pkgs, ... }:

{
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fish/config.fish - - - - ${toString ./config/config.fish}"
  ];
}