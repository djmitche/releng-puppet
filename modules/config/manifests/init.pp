# the keys in this file are documented in
#   https://wiki.mozilla.org/ReleaseEngineering/PuppetAgain#Config
# if you add a new key here, add it to the wiki as well!

# We use config rather than settings because "settings" is a magic class
class config {
    include config::secrets
    
    $puppet_notif_email = extlookup("puppet_notif_email")
    $puppet_server = extlookup("puppet_server")
    $yum_server = extlookup("yum_server")
    $repo_servers = extlookup("repo_servers")
    $builder_username = extlookup("builder_username")
    $nrpe_allowed_hosts = extlookup("nrpe_allowed_hosts")
    $ntp_server = extlookup("ntp_server")
}
