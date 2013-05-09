# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class packages::ccache {
    case $::operatingsystem {
        CentOS: {
            package {
                "ccache":
                    ensure => latest;
            }
        }
        Darwin: {
            packages::pkgdmg {
                ccache:
                    # this package was copied from the old releng puppet; its
                    # provenance is unknown.
                    version => "3.1.7";
            }
        }

        default: {
            fail("cannot install on $::operatingsystem")
        }
    }
}
