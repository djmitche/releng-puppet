# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class supervisord::base {
    include packages::mozilla::supervisor

    file {
        '/etc/supervisord.conf':
            source => 'puppet:///modules/supervisord/supervisord.conf',
            notify => Service['supervisord'];

        '/etc/supervisord.d/':
            ensure => directory,
            notify => Service['supervisord'],
            recurse => true,
            purge => true;
        "/etc/supervisord.conf.d/":
            recurse => true,
            force => true,
            ensure => absent;
    }

    case $::operatingsystem {
        CentOS: {
            service {
                "supervisord":
                    require => [
                        Class["packages::mozilla::supervisor"],
                        File["/etc/supervisord.conf"],
                    ],
                    enable => true,
                    ensure => running,
                    restart => "/usr/bin/supervisorctl update",
                    start => "/sbin/service supervisord start",
                    stop => "/sbin/service supervisord stop",
                    hasstatus => true,
                    status => "/sbin/service supervisord status";
            }
        }
        default: {
            fail("Supervisord is not supported on this platform")
        }
    }
}
