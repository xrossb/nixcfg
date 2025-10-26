{ ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      "SearchEngines" = {
        "Default" = "DuckDuckGo";
      };
      "Homepage" = {
        "StartPage" = "previous-session";
      };
    };
  };
}
