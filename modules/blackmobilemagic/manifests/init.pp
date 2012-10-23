class blackmobilemagic($admin=purple) {
    include dirs::opt::bmm

    notify {
        "admin is $admin": ;
    }

    class {
        blackmobilemagic::config::httpd: ;
        blackmobilemagic::config::tftpd: ;
        blackmobilemagic::config::rsyslog: ;
        blackmobilemagic::config::frontend:
            admin => $admin;
    }
}
