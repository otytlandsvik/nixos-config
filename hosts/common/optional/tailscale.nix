_: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [
      "--login-server=https://headscale.svc.oceanbox.io"
      "--accept-dns"
      "--accept-routes"
    ];
  };
}
