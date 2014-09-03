# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class packages::mozilla::py27_mercurial {

    anchor {
        'packages::mozilla::py27_mercurial::begin': ;
        'packages::mozilla::py27_mercurial::end': ;
    }

    include packages::mozilla::python27

    $mercurial = "/tools/python27-mercurial/bin/hg"
    case $::operatingsystem {
        CentOS: {
            Anchor['packages::mozilla::py27_mercurial::begin'] ->
            package {
                "mozilla-python27-mercurial":
                    ensure => '2.5.4-1.el6',
                    require => Class['packages::mozilla::python27'];
            } -> Anchor['packages::mozilla::py27_mercurial::end']
        }
        Ubuntu: {
            # NOTE: the upstream (Ubuntu) mercurial just happened to be the
            # desired version here, so we used it.  In future, we should build
            # our own Mercurial.
            include packages::mercurial
            Anchor['packages::mozilla::py27_mercurial::begin'] ->
            file {
                ["/tools/python27-mercurial", "/tools/python27-mercurial/bin"]:
                    ensure => directory;
                "/tools/python27-mercurial/bin/hg":
                    ensure => link,
                    target => "/usr/bin/hg";
            } -> Anchor['packages::mozilla::py27_mercurial::end']
        }
        Darwin: {
            Anchor['packages::mozilla::py27_mercurial::begin'] ->
            packages::pkgdmg {
                python27-mercurial:
                    os_version_specific => false,
                    version => "2.5.4-3";
            } -> Anchor['packages::mozilla::py27_mercurial::end']
        }
        default: {
            fail("cannot install on $::operatingsystem")
        }
    }
}
