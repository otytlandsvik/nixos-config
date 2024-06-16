{ ... }:
{
  # Login manager
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        theme_name = "Adwaita";
      };
    };
  };
}
