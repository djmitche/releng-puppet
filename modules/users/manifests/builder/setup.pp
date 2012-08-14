class users::builder::setup($home, $username, $group) {
    anchor {
        'users::builder::setup::begin': ;
        'users::builder::setup::end': ;
    }

    ##
    # install a pip.conf for the builder user

    Anchor['users::builder::setup::begin'] ->
    python::user_pip_conf {
        $username:
            homedir => $home,
            group => $group;
    } -> Anchor['users::builder::setup::end']

    ##
    # set up SSH configuration

    Anchor['users::builder::setup::begin'] ->
    ssh::userconfig {
        $username:
            home => $home,
            group => $group,
            authorized_keys => $::config::global_authorized_keys,
            config => template("users/builder-ssh-config.erb");
    } -> Anchor['users::builder::setup::end']

    ##
    # Manage some configuration files

    file {
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
}
