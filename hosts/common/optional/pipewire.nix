{ pkgs, ... }:
{
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pamixer # pulseaudio sound mixer
    pavucontrol # pulseaudio volume control
  ];
}
