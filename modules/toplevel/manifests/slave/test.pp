class toplevel::slave::test inherits toplevel::slave {
    # test slaves need to login so we can run graphical processes as a user
    include users::builder::autologin
    # and need to have a well-known screen resolution for talos tests
    include screenresolution::talos
    include ntp::atboot
}

