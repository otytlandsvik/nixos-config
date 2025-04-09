_: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--login-server=https://headscale.ekman.oceanbox.io" ];
  };
}
