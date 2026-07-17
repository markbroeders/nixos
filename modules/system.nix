{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Route the core EFI files to the Windows partition
  boot.loader.efi.efiSysMountPoint = "/efi"; 

  # Route the heavy NixOS generation kernels to the XBOOTLDR partition
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Automatically collect garbage weekly, keeping the last 14 days of
  # generations, and dedupe identical store files via hardlinks.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  networking.hostName = "wheeler"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Work around an iwlwifi (Intel AX211) resume race: right after waking
  # from suspend, the firmware is still reinitializing (regdom/RFIm) when
  # wpa_supplicant's first reconnect attempt goes out, causing 1-2 failed
  # handshakes before it self-heals. Force a clean reconnect after the
  # firmware has had time to settle instead of waiting out the retry backoff.
  powerManagement.resumeCommands = ''
    ${pkgs.networkmanager}/bin/nmcli device disconnect wlo1 || true
    sleep 5
    ${pkgs.networkmanager}/bin/nmcli device connect wlo1 || true
  '';

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "nl_NL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
