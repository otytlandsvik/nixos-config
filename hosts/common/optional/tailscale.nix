_: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [
      "--login-server=https://hscl.t0.itpartner.no"
      "--accept-dns"
      "--accept-routes"
    ];
  };
}
