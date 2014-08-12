# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class web_proxy::gui {
    include users::root

    $proxy_enabled = $web_proxy::host != ""

    case $operatingsystem {
        Darwin: {
            file {
                "/usr/local/bin/setproxy.sh" :
                    ensure => present,
                    owner => "$users::root::username",
                    group => "$users::root::group",
                    mode => 0755,
                    content => template("${module_name}/gui_Darwin.erb"),
                    notify => Exec["set-proxy-gui-darwin"] ;
            }

            exec {
                "set-proxy-gui-darwin" :
                    command => "/usr/local/bin/setproxy.sh",
                    refreshonly => true;
            }
        }
        Ubuntu: {
            $schema_dir = "/usr/share/glib-2.0/schemas/"

            file {
                "${schema_dir}/99_puppet_webproxy.gschema.override" :
                    ensure => $proxy_enabled ? { true => present, default => absent },
                    owner => "$users::root::username",
                    group => "$users::root::group",
                    mode => 0544,
                    content => template("${module_name}/gui_Ubuntu.erb"),
                    notify => Exec["set-proxy-gui-ubuntu"] ;
            }

            exec {
                "set-proxy-gui-ubuntu" :
                    command => "/usr/bin/glib-compile-schemas ${schema_dir}",
                    refreshonly => true;
            }
        }
    }
}
