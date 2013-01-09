# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class packages::mozilla::python27 {
    anchor {
        'packages::mozilla::python27::begin': ;
        'packages::mozilla::python27::end': ;
    }

    case $::operatingsystem {
        CentOS: {
	    Anchor['packages::mozilla::python27::begin'] ->
            package {
                "mozilla-python27":
                    ensure => latest;
            } -> Anchor['packages::mozilla::python27::end']
        }
        Darwin: {
	    Anchor['packages::mozilla::python27::begin'] ->
            packages::pkgdmg {
                python27:
                    version => "2.7.2-1";
            } -> Anchor['packages::mozilla::python27::end']
        }
        default: {
            fail("cannot install on $operatingsystem")
        }
    }
}
