// see e.g. https://github.com/milgradesec/firefox-settings

// HTTPS only
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

// disable OCSP (privacy, leaking to CA), enforce CRLite revocation checks
user_pref("security.OCSP.enabled", 0);
user_pref("security.OCSP.require", false);
user_pref("security.remote_settings.crlite_filters.enabled", true);
user_pref("security.pki.crlite_mode", 2);

// privacy
user_pref("geo.enabled", false);
user_pref("dom.battery.enabled", false);
user_pref("pdfjs.enableScripting", false);
user_pref("browser.contentblocking.category", "strict");

// compact UI
user_pref("browser.uidensity", 1);

// display advanced information on Insecure Connection warning pages
user_pref("browser.xul.error_pages.expert_bad_cert", true);
