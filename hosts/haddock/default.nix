# Beiste: home desktop
{ ... }:
{
  imports = [
    ################ Required ################
    ./hardware-configuration.nix
    ../common/core

    ################ Host specific optionals ################
    ../common/optional/hyprland.nix # Window manager
    ../common/optional/pipewire.nix # Sound config
    ../common/optional/regreet.nix # Login manager
    ../common/optional/blueman.nix # Bluetooth applet
    ../common/optional/openssh.nix # SSH Daemon
    ../common/optional/nix-ld.nix # Dynamic library patcher
    ../common/optional/tailscale.nix # VPN

    ################ Users to create  ################
    ../common/users/ole.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    initrd.luks.devices.luksroot = {
      device = "/dev/nvme0n1p1";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # DNS masking for Atlantis
  services.dnsmasq = {
    enable = true;
    settings.address = [
      "/.local/127.0.0.1"
      "/.local.oceanbox.io/127.0.0.1"
    ];
  };

  networking.hostName = "haddock";

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  environment.sessionVariables = { };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
