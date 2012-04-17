define packages::yumrepo ($repo_name = $title, $baseurl, $gpg_key='', $gpg_key_pkg='') {

    # For now (puppet 2.7.1 as of this writing)
    # we have to use the file resource here, the
    # yumrepo resource is unable to purge. And even if
    # we set the yum.repos.d directory to purge the
    # yumrepo resource does not mark the created files
    # as managed, so we would end up continuously deleting
    # and creating files.
    file {
        "/etc/yum.repos.d/$repo_name.repo":
            content => template("packages/yumrepo.erb");
    }

    if ($gpg_key) {
        exec {
            "install-$repo_name-gpg-key":
                command => "/bin/rpm --import $gpg_key",
                unless => "/bin/rpm -q $gpg_key_pkg"
        }
    }
}
