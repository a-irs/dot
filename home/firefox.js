// see e.g. https://github.com/milgradesec/firefox-settings

// enable ECH/ESNI
// test e.g. with https://crypto.cloudflare.com/cdn-cgi/trace
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.http3_echconfig.enabled", true);

// Use TRR first, and only if the name resolve fails use the native resolver as a fallback
user_pref("network.trr.mode", 2);
user_pref("network.trr.uri", "https://firefox.dns.nextdns.io/");

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
