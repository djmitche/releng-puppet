class mockbuild {
    include packages::mozilla::mock_mozilla

            file {
                "/etc/mock_mozilla/mozilla-f11-i386.cfg":
                    ensure => present,
                    source => "puppet:///modules/packages/mozilla-f11-i386.cfg";
            }
}
