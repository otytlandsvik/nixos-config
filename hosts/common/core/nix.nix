{ ... }:
{
  nix = {
    settings = {

      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    # Garbage collection
    # gc = {
    #   automatic = true;
    #   options = "--delete-older-than 10d";
    # };
  };
}
