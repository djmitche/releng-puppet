# This is a class that describes a fairly generic set of mozilla
# tools packages

class packages::mozilla-tools {
    include dirs::tools

    case $operatingsystem{
        CentOS: {
            # These are mozilla custom tools
            package {
                "mozilla-python27-mercurial":
                    ensure => latest,
                    require => Class['packages::python27'];
                "mozilla-python27-virtualenv":
                    ensure => latest,
                    require => Class['packages::python27'];
            }

        }
        default: {
            fail("cannot install on $operatingsystem")
        }
    }
}
