{ pkgs, ... }:
{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      pamixer # pulseaudio sound mixer
      pavucontrol # pulseaudio volume control
      ;
  };
}
