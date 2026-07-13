{ pkgs, ... }:

{
systemd.user.tmpfiles.rules = [
    "L+ %h/.config/starship.toml - - - - ${./starship.toml}"
  ];
}
