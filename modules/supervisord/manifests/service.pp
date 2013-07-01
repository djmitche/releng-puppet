# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

define supervisord::service($command, $user,
        $autostart=true, $autorestart=true, $environment=[], $extra_config='',
        $restart_command='')
{
    include supervisord::base

    $supervisor_name = $name
    file {
        "/etc/supervisord.d/${name}.conf":
            notify => Service['supervisord'],
            content => template("supervisord/snippet.erb");
    }

    case $::operatingsystem {
        CentOS: {
            file {
                "/etc/init.d/${name}":
                    mode => '0755',
                    content => template("supervisord/service-initd.erb");
            }
            service {
                $supervisor_name:
                    require => File["/etc/init.d/${supervisor_name}",
                                    "/etc/supervisord.conf.d/${supervisor_name}.conf"],
                    enable => true,
                    ensure => running,
                    status  => "/usr/bin/supervisorctl status ${supervisor_name} | awk '/^${supervisor_name}[: ]/{print \$2}' | grep '^RUNNING$'",
                    restart => "/usr/bin/supervisorctl restart ${supervisor_name} | awk '/^${supervisor_name}[: ]/{print \$2}' | grep -Pzo '^stopped\nstarted$'",
                    start   => "/usr/bin/supervisorctl start ${supervisor_name} | awk '/^${supervisor_name}[: ]/{print \$2}' | grep '^started$'",
                    stop    => "/usr/bin/supervisorctl stop ${supervisor_name} | awk '/^${supervisor_name}[: ]/{print \$2}' | grep '^stopped$'",
            }
        }
    }
}
