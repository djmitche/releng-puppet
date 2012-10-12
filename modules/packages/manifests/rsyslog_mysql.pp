class packages::rsyslog_mysql {
    case $operatingsystem {
        CentOS: {
            package {
                "rsyslog-mysql":
                    ensure => latest;
            }
        }

        default: {
            fail("cannot install on $operatingsystem")
        }
    }
}
