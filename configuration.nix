# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./Machine/KDE/plasma-fix.nix
      ./Machine/Helium/helium-browser.nix
      ./Machine/fastfetch/fastfetch-config.nix
      ./Machine/fish/fish-config.nix
      ./Machine/Starship/starship-config.nix
      ./Machine/kitty/kitty-config.nix
      inputs.gsr-ui-nix.nixosModules.default
    ];
    services.avahi = {
  enable = true;
  nssmdns4 = true;      # Allows resolving .local hostnames
  openFirewall = true;  # Opens UDP 5353 for local network discovery
};

    users.extraUsers.matko.extraGroups = [ "vboxusers" ];
    virtualisation.virtualbox.host.enable = true;
    programs.gpu-screen-recorder = {
      package = inputs.gsr-ui-nix.packages.${pkgs.stdenv.hostPlatform.system}.gpu-screen-recorder;
      enable = true;
      ui.enable = true;
    };
  # Gaming
     programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
     extraPackages = with pkgs; [ kdePackages.breeze ];
   };
     hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  services.flatpak.enable = true;
  # Fish
  programs.fish.enable = true;
  users.users.matko = {
    shell = pkgs.fish;
  };
  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "fishy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bratislava";

  # Select internationalisation properties.
  i18n.defaultLocale = "sk_SK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sk_SK.UTF-8";
    LC_IDENTIFICATION = "sk_SK.UTF-8";
    LC_MEASUREMENT = "sk_SK.UTF-8";
    LC_MONETARY = "sk_SK.UTF-8";
    LC_NAME = "sk_SK.UTF-8";
    LC_NUMERIC = "sk_SK.UTF-8";
    LC_PAPER = "sk_SK.UTF-8";
    LC_TELEPHONE = "sk_SK.UTF-8";
    LC_TIME = "sk_SK.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
  enable = true;
  theme = "breeze";

  # This sets your resolution and refresh rate via the absolute path to xrandr
  setupScript = ''
    ${pkgs.xrandr}/bin/xrandr --output DP-2 --mode 1920x1080 --rate 165
  '';

  settings = {
    General = { Numlock = "on"; };
    Theme = { CursorTheme = "breeze_cursors"; };
  };
};
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "sk";
    variant = "qwerty";
  };

  # Configure console keymap
  console.keyMap = "sk-qwerty";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."matko" = {
    isNormalUser = true;
    description = "Matko";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      prismlauncher
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      kdePackages.kate
      git
      protonplus
      mpv
      vscode
      opencode-desktop
      yt-dlp
      kitty
      fuse
      cava
      pear-desktop
      mpvScripts.visualizer
      equibop
      godot
      ollama-rocm
      litellm
      python314Packages.kokoro
      kdePackages.filelight
      uv
      wivrn
      wayvr
      xrizer
    ];
  };

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  appimage-run
  gearlever
  steamcmd
  fastfetch
  starship
  wine
  ];
  programs.kdeconnect.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
