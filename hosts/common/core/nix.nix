{ ... }:
{
  nix = {
    settings = {

      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      # Enable flakes and pipes
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };

    # Garbage collection
    # gc = {
    #   automatic = true;
    #   options = "--delete-older-than 10d";
    # };
  };
}
