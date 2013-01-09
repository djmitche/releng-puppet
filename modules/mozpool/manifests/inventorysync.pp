class mozpool::inventorysync {
    # only the admin node should do the inventory sync, and only in production
    if ($is_bmm_admin_host and !$mozpool_staging) {
        file {
            "/etc/cron.d/mozpool-inventorysync":
                content => "15,45 * * * * apache MOZPOOL_CONFIG=${::mozpool::settings::config_ini} ${::mozpool::settings::root}/frontend/bin/mozpool-inventorysync\n";
        }
    } else {
        file {
            "/etc/cron.d/mozpool-inventorysync":
                ensure => absent;
        }
    }
}
