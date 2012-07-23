# Ensure that a buildslave starts up on this machine

class buildslave::startup {
    include ::shared
    include buildslave::install
    include dirs::usr::local::bin

    # everyone uses runslave.py in the same place
    file {
        "/usr/local/bin/runslave.py":
            source => "puppet:///modules/buildslave/runslave.py",
            owner  => "root",
            group => $::shared::root_group,
            mode => 755;
    }

    # select an implementation class based on operating system
    $startuptype = $operatingsystem ? {
        CentOS      => "initd",
        Darwin      => "launchd"
        # not done in PuppetAgain yet:
        #Fedora      => "desktop",
    }
    class { "buildslave::startup::$startuptype": }
}
