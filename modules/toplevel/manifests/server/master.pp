# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class toplevel::server::master inherits toplevel::server {
    # incomplete
    include nrpe

    # this might be too much - check before using
    # also, note check_mysql doesn't work yet
    include nagios::check::buildbot
    include nagios::check::ide_smart
    include nagios::check::procs_regex
    include nagios::check::child_procs_regex
    include nagios::check::swap
    include nagios::check::mysql
    include nagios::check::ntp_time
    include nagios::check::http_redirect_ip
    include nagios::check::ganglia
}
