# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
class dirs::builds::slave {
    include dirs::builds
    include users::builder
    include config
   
    file {
            "/builds/slave" :
            ensure => directory,
            owner => "$users::builder::username",
            group => "$users::builder::group",
            mode => 0755;
    }
}
