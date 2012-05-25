class toplevel::slave::build::mock inherits toplevel::slave::build {
    include packages::mozilla::mock_mozilla

    User[$config::builder_username] {
        groups => [ 'mock_mozilla' ]; # TODO: and mock?
    }
}
