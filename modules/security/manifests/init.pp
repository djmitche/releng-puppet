# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class security {
    include ::config

    # including this class just gets you $security::level, which corresponds to
    # the host's system security level, as defined in
    # https://mana.mozilla.org/wiki/display/ITSECURITY/IT+System+security+guidelines
    # Other modules then alter their configurations depending on the host's security level.
    #
    # The available levels are "low", "medium", "high", and "maximum".
    #
    # The level for a specific host can be specified in a node definition by
    # setting $node_security_level; if that is not set, then the security level is
    # config::default_security_level.

    if "${node_security_level}" == "" {
        $level = $::config::default_security_level
    } else {
        $level = $node_security_level
    }

    # the following booleans can help determine if a host is at the given level
    # or above.
    case $level {
        low: {
            $low = true
            $medium = false
            $high = false
            $maximum = false
        }
        medium: {
            $low = true
            $medium = true
            $high = false
            $maximum = false
        }
        high: {
            $low = true
            $medium = true
            $high = true
            $maximum = false
        }
        maximum: {
            $low = true
            $medium = true
            $high = true
            $maximum = true
        }
    }
}
