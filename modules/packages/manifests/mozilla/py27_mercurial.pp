# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class packages::mozilla::py27_mercurial {


    anchor {
        'packages::mozilla::py27_mercurial::begin': ;
        'packages::mozilla::py27_mercurial::end': ;
    }

    include packages::mozilla::python27

    case $::operatingsystem {
        CentOS: {
            $mercurial = "/tools/python27-mercurial/bin/hg"
            Anchor['packages::mozilla::py27_mercurial::begin'] ->
            package {
                "mozilla-python27-mercurial":
                    ensure => latest,
                    require => Class['packages::mozilla::python27'];
            } -> Anchor['packages::mozilla::py27_mercurial::end']
        }
        Ubuntu: {
            include packages::mercurial
            $mercurial = "/usr/bin/hg"
            Anchor['packages::mozilla::py27_mercurial::begin'] ->
            file {
                ["/tools/python27-mercurial", "/tools/python27-mercurial/bin"]:
                    ensure => directory;
                $mercurial:
                    ensure => link,
                    target => "/usr/bin/hg";
            } -> Anchor['packages::mozilla::py27_mercurial::end']
        }
        Darwin: {
            $mercurial = $macosx_productversion_major ? {
                10.6 => "/tools/python27_mercurial/bin/hg",
                default => "/tools/mercurial/bin/hg",
            }
            Anchor['packages::mozilla::py27_mercurial::begin'] ->
            packages::pkgdmg {
                python27-mercurial:
                    version => $macosx_productversion_major ? {
                        10.6 => "2.5.4-2",
                        default => "2.5.4-1", # pending bug 895995
                    };
            } -> Anchor['packages::mozilla::py27_mercurial::end']
        }
        default: {
            fail("cannot install on $::operatingsystem")
        }
    }
}
