# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class signingserver::base {
    include dirs::builds
    include users::signer

    # OS X does not yet support firewall manipulation
    if $::operatingsystem != 'Darwin' {
        include fw
    }

    # nagios checks for signing
    include nrpe::check::child_procs_regex
    include nrpe::check::ntp_time

    # lots of packages for signing, with some differing between operating
    # systems
    include packages::mozilla::python27
    include packages::mozilla::py27_mercurial
    include packages::libevent
    include packages::mozilla::signing_test_files
    include packages::gnupg

    # note that signmar installs different versions on different operating
    # systems; see signmar.pp for details.
    include packages::mozilla::signmar

    $root = "/builds/signing"

    case $::operatingsystem {
        CentOS: {
            include packages::mono
            include packages::openssl
            include packages::nss_tools
            include packages::libevent
            include packages::jdk16
            include packages::gcc
            include packages::mozilla::android_sdk16

            $compiler_req = Class['packages::gcc']
        }
        Darwin: {
            include packages::xcode

            $compiler_req = Class['packages::xcode']

            file {
                "${root}/DeveloperIDCA.cer":
                    source => "puppet:///modules/signingserver/DeveloperIDCA.cer";
            }

            exec {
                "install-developer-id-root":
                    command => "/usr/bin/security add-trusted-cert -r trustAsRoot -k /Library/Keychains/System.keychain ${root}/DeveloperIDCA.cer",
                    require => File["${root}/DeveloperIDCA.cer"],
                    unless => "/usr/bin/security dump-keychain /Library/Keychains/System.keychain | /usr/bin/grep 'Developer ID Certification'",
                    # This command returns an error despite actually importing
                    # the certificate correctly.
                    # For posterity, the error returned is "SecTrustSettingsSetTrustSettings: The authorization was denied since no user interaction was possible.".
                    returns => [1];
            }
        }
    }

    file {
        # instances are stored with locked-down perms
        $root:
            ensure => directory,
            owner => $users::signer::username,
            group => $users::signer::group,
            mode => '0700';
    }

    motd {
        "signing":
            content => "This signing server hosts the following instances:\n",
            order => 90;
    }

    # NOTE: on CentOS, packages::jdk16 installs jarsigner in the default PATH
    # lrwxrwxrwx 1 root root 27 Jun 26 10:54 /usr/bin/jarsigner -> /etc/alternatives/jarsigner
}
