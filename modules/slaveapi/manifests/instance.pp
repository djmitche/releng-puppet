# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

define slaveapi::instance($listenaddr, $port, $version="1.1.1") {
    include config
    include slaveapi::base
    include users::builder

    $basedir = "${slaveapi::base::root}/${title}"
    $credentials_file = "${basedir}/credentials.json"
    $config_file = "${basedir}/slaveapi.ini"
    if (has_aspect("dev")) {
        $bugzilla_url = $::config::slaveapi_bugzilla_dev_url
    }
    else {
        $bugzilla_url = $::config::slaveapi_bugzilla_prod_url
    }

    motd {
        "slaveapi-$title":
            content => "* port ${port} in ${basedir}\n",
            order => 91;
    }


    $user = $users::builder::username
    $group = $users::builder::group

    python::virtualenv {
        "${basedir}":
            python => $packages::mozilla::python27::python,
            require => [
                Class['packages::mozilla::python27'],
                Class['packages::libevent'],
                $slaveapi::base::compiler_req, # for compiled extensions
            ],
            user => $user,
            group => $group,
            packages => [
                "gevent==0.13.8",
                "greenlet==0.4.1",
                "pycrypto==2.6",
                # unused, but one of the vendor libraries (Flask) requires it
                "Jinja2==2.7.1",
                "MarkupSafe==0.18",
                "WebOb==1.2.3",
                "requests==1.2.3",
                "bzrest==0.7",
                "dnspython==1.11.1",
                "paramiko==1.11.0",
                "Flask==0.10.1",
                "Werkzeug==0.9.3",
                "itsdangerous==0.23",
                "docopt==0.6.1",
                "python-daemon==1.5.5",
                "gevent_subprocess==0.1.1",
                "furl==0.3.5",
                "orderedmultidict==0.7.1",
                "pytz==2013.7",
                "slaveapi==${version}",
                "mozpoolclient==0.1.5",
                "python-dateutil==1.5",
            ];
    }

    file {
        "${config_file}":
            content => template("slaveapi/slaveapi.ini.erb"),
            owner => $user,
            group => $group,
            notify => Exec["$title-reload-slaveapi-server"],
            require => Python::Virtualenv["$basedir"];
        "${credentials_file}":
            content => template("slaveapi/credentials.json.erb"),
            owner => $user,
            group => $group,
            notify => Exec["$title-reload-slaveapi-server"],
            require => Python::Virtualenv["$basedir"],
            show_diff => false;
    }

    exec {
        "$title-reload-slaveapi-server":
            command => "${basedir}/bin/slaveapi-server.py reload ${config_file}",
            cwd => $basedir,
            user => $user,
            onlyif => "/bin/sh -c 'test -e ${basedir}/slaveapi.pid'",
            refreshonly => true;
        "$title-start-slaveapi-server":
            command => "${basedir}/bin/slaveapi-server.py start ${config_file}",
            cwd => $basedir,
            user => $user,
            require => [
                Python::Virtualenv["$basedir"],
                File["${config_file}"],
                File["${credentials_file}"],
            ],
            unless => "/bin/sh -c 'test -e ${basedir}/slaveapi.pid'";
    }
}
