# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class timezone {

    include packages::tzdata

    case $::operatingsystem {
        CentOS: {
            file {
                "/etc/localtime":
                    mode => 644,
                    owner => root,
                    group => $users::root::group,
                    content => file("/usr/share/zoneinfo/US/Pacific"),
                    force => true,
                    require => Class['packages::tzdata'];
            }
            exec {
                "/usr/sbin/tzdata-update":
                    subscribe => File["/etc/localtime"],
                    refreshonly => true;
            }
        }
        Darwin: {
            osxutils::systemsetup {
                timezone:
                    setting => "America/Los_Angeles";
            }
        }
    }
}
