# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class packages::libc {
    case $::operatingsystem {
        CentOS: {
            # do nothing for now
        }

        Darwin: {
            # default version is fine
        }

        Ubuntu: {
            realize(Packages::Aptrepo['eglibc'])
            case $::operatingsystemrelease {
                12.04: {
                    package {
                        "libc6":
                            ensure => '2.15-0ubuntu10.10';
                    }
                }
                default: {
                    # default version is fine
                }
            }
        }

        default: {
            fail("cannot install on $::operatingsystem")
        }
    }
}

