{ pkgs, ... }:

{
  programs.fish = {
    interactiveShellInit = builtins.readFile ./config/config.fish;
  };
}
