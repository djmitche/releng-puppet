class packages::tftp-server {
    case $operatingsystem {
        CentOS: {
            package {
                "tftp-server":
                    ensure => latest,
                    require => Class["packages::xinetd"];
            }
        }

        default: {
            fail("cannot install on $operatingsystem")
        }
    }
}
