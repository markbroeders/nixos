{ config, pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Install Flatpak
  services.flatpak.enable = true;

  services.tailscale.enable = true;

  services.syncthing = {
    enable = true;
    user = "mark";
    dataDir = "/home/mark/Documenten"; # default location for new folders
    configDir = "/home/mark/.config/syncthing";
    openDefaultPorts = true; # Open ports in the firewall for Syncthing
  };

  # Batterij laadlimiet instellen op 80% voor ASUS laptop
  systemd.services.battery-charge-threshold = {
    description = "Stel batterij laadlimiet in op 80% (ASUS)";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'if [ -e /sys/class/power_supply/BAT0/charge_control_end_threshold ]; then echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold; fi'";
    };
  };

  # Connect devices via USB, needed for Calibre
  services.udisks2.enable = true;
}
