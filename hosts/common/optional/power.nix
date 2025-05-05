{ ... }:
{
  # Power management settings for systems with a battery
  services.tlp.enable = true;
  services.thermald.enable = true;
  # Could also be 'schedutil'
  powerManagement.cpuFreqGovernor = "powersave";

  # Avoid shutting down on power button short press
  services.logind.powerKey = "ignore";
}
