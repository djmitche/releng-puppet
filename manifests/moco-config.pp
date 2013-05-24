# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class config inherits config::base {
    $org = "moco"

    $puppet_notif_email = "releng-shared@mozilla.com"
    $puppet_server_reports = "tagmail,http"
    $puppet_server_reporturl = "http://puppetdash.pvt.build.mozilla.org/reports/upload"
    $builder_username = "cltbld"

    # we use the sort_servers_by_group function to sort the list of servers, and then just use
    # the first as the primary server
    $grouped_puppet_servers = {
        ".*\\.mtv1\\.mozilla\\.com" => [
           "releng-puppet2.build.mtv1.mozilla.com",
        ],
        ".*\\.scl1\\.mozilla\\.com" => [
           "releng-puppet2.build.scl1.mozilla.com",
        ],
        ".*\\.releng\\.scl3\\.mozilla\\.com" => [
           "releng-puppet2.srv.releng.scl3.mozilla.com",
        ],
        ".*\\.releng\\.(use1|aws-us-east-1)\\.mozilla\\.com" => [
            "releng-puppet1.srv.releng.use1.mozilla.com",
            "releng-puppet2.srv.releng.use1.mozilla.com",
        ],
        ".*\\.releng\\.(usw2|aws-us-west-2)\\.mozilla\\.com" => [
            "releng-puppet1.srv.releng.usw2.mozilla.com",
            "releng-puppet2.srv.releng.usw2.mozilla.com",
        ],
    }
    $puppet_servers = sort_servers_by_group($grouped_puppet_servers)
    $puppet_server = $puppet_servers[0]
    $data_servers = $puppet_servers
    $data_server = $puppet_server

    $distinguished_puppetmaster = "releng-puppet2.build.scl1.mozilla.com"
    $puppet_again_repo = "http://hg.mozilla.org/users/dmitchell_mozilla.com/puppet320/"

    $nrpe_allowed_hosts = "10.2.71.20,10.12.75.9,127.0.0.1,10.26.75.30"
    $ntp_server = "ntp.build.mozilla.org"
    $global_authorized_keys = [
        "armenzg",
        "arr",
        "asasaki",
        "bhearsum",
        "callek",
        "catlee",
        "cltbld",
        "coop",
        "dustin",
        "hwine",
        "jhopkins",
        "joduinn",
        "jwatkins",
        "kmoir",
        "mgervasini",
        "nthomas",
        "pmoore",
        "rail",
        "release-runner",
        "sbruno",
        "zandr",
    ]
    $buildbot_mail_to = "release@mozilla.com"
}

