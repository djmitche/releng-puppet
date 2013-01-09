# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
define httpd::config ($file = $title, $contents = '') {
    case $operatingsystem {
        Darwin : {
            include httpd
            include packages::httpd
            include httpd::settings
            if ($file != undef) and ($contents != undef) {
                file {
                    "$file" :
                        notify => Service['org.apache.httpd'],
                        require => Class['packages::httpd'],
                        path => "/etc/apache2/other/$file",
                        mode => "$httpd::settings::mode",
                        owner => "$httpd::settings::owner",
                        group => "$httpd::settings::group",
                        content => $contents ;
                }
            }
        }
        CentOS : {
            include httpd
            include packages::httpd
            include httpd::settings
            if ($file != undef) and ($contents != undef) {
                file {
                    "$file" :
                        notify => Service['httpd'],
                        require => Class['packages::httpd'],
                        path => "/etc/httpd/conf.d/$file",
                        mode => "$httpd::settings::mode",
                        owner => "$httpd::settings::owner",
                        group => "$httpd::settings::group",
                        content => $contents ;
                }
            }
        }
    }
}
