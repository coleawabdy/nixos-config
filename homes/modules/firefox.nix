{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
      localcdn
      xbrowsersync
      kristofferhagen-nord-theme
    ];
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "app.shield.optoutstudies.enabled" = true;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "browser.contentblocking.category" = "strict";
        "browser.discovery.enabled" = false;
        "browser.formfill.enable" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.startup.page" = 0;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "extensions.activeThemeID" = "{e410fec2-1cbd-4098-9944-e21e708418af}";
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "places.history.enabled" = false;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.session" = true;
        "signon.autofillForms" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.prefillForms" = false;
        "signon.rememberSignons" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
      };
    };
  };
}
