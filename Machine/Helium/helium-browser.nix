{ config, pkgs, ... }:

{
  programs.helium = {
    enable = true;

    # 🚩 Flags - Command-line arguments always passed to Helium
    flags = [
      "--disable-gpu"
      "--ozone-platform-hint=auto"
    ];

    # 🎯 Policies - Written to /etc/chromium/policies/managed/helium-nixos.json
    policies = {
      "BrowserSignin" = 0;
      "PasswordManagerEnabled" = false;
      "SyncDisabled" = true;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [ "en-US" ];
    };
  };
}
