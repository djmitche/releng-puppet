# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class ntp::atboot {
    include packages::ntp

    case $operatingsystem {
        'CentOS', 'Darwin': {
            service {
                "ntpdate":
                    enable => true,
                    hasstatus => false;
            }
        }
        default: {
            fail("cannot instantiate on $operatingsystem")
        }
    }
}
