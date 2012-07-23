# Set up the builder user - this is 'cltbld' on firefox systems, but flexible
# enough to be anything

class users::builder {
    include config

    # public variables used by other modules
    $username = $::config::builder_username

    #files are owned by staff group on macosx, rather than a group named after the user
    $group = $operatingsystem ? {
        Darwin => 'staff',
        default => $username
    }

    #specifying the uid is temporary util usr is fixed on 10.8 in puppet   
    $uid = $operatingsystem ? {
        Darwin => 501,
        default => 500
    }
   
    # calculate the proper homedir
    $home = $operatingsystem ? {
        Darwin => "/Users/$username",
        default => "/home/$username"
    }

    # sanity checks

    if ($config::secrets::builder_pw_hash == '') {
        fail('No builder password hash set')
    }

    if ($username == '') {
        fail('No builder username set')
    }

    case $::operatingsystem {
        CentOS: {
            user {
                $username:
                    password => $config::secrets::builder_pw_hash,
                    shell => "/bin/bash",
                    managehome => true,
                    comment => "Builder";
            }
        }
        Darwin: {
            # TODO
        }
    }

    # Manage some configuration files
    file {
        "$home/.ssh":
            ensure => directory,
            mode => 0755,
            owner => $username,
            group => $group;
        "$home/.ssh/config":
            mode => 0644,
            owner => $username,
            group => $group,
            source => "puppet:///modules/users/ssh_config";
        # XXX Authorized keys should be generated from LDAP not a static file
        "$home/.ssh/authorized_keys":
            mode => 0644,
            owner => $username,
            group => $group,
            content => template("users/ssh_authorized_keys.erb");
        "$home/.ssh/known_hosts":
            mode => 0644,
            owner => $username,
            group => $group,
            source => "puppet:///modules/users/ssh_known_hosts";
        "$home/.gitconfig":
            mode => 0644,
            owner => $username,
            group => $group,
            source => "puppet:///modules/users/gitconfig";
        "$home/.bashrc":
            mode => 0644,
            owner => $username,
            group => $group,
            content => template("${module_name}/builder-bashrc.erb");
        "$home/.hgrc":
            mode => 0644,
            owner => $username,
            group => $group,
            source => "puppet:///modules/users/hgrc";
        "$home/.vimrc":
            mode => 0644,
            owner => $username,
            group => $group,
            source => "puppet:///modules/users/vimrc";
        "$home/.screenrc":
            mode => 0644,
            owner => $username,
            group => $group,
            source => "puppet:///modules/users/screenrc";

    }

    python::user_pip_conf {
        $username: ;
            homedir => $home,
            group => $group;
    }
}

