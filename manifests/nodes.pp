node /bld-centos6-hp-\d+.build.scl1.mozilla.com/ {
    include toplevel::slave::build::mock
}

node "relabs07.build.mtv1.mozilla.com" {
    include toplevel::slave::build
}

node "relabs08.build.mtv1.mozilla.com" {
    include toplevel::slave::build::mock
}

node "relabs-buildbot-master.build.mtv1.mozilla.com" {
    include toplevel::server
}

node "relabs-slave.build.mtv1.mozilla.com" {
    include toplevel::slave::test
}

node /foopy\d+.build.mtv1.mozilla.com/ {
    include toplevel::server::foopy
}

node /foopy\d+.build.scl1.mozilla.com/ {
    include toplevel::server::foopy
}

node "linux-foopy-test.build.mtv1.mozilla.com" {
    include toplevel::server::foopy
}

node /r5/ {
    include users::builder
    ssh::known_host {
        "bm-remote-talos-webhost-01.build.mozilla.org":
            hostkey => "bm-remote-talos-webhost-01.build.mozilla.org,10.250.50.170 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA4spGs7xzChHk5EwqZU4X2LM/nxkZSywIQsMvSnrYaQCewuc87vQzgp4RwTdKbrBCox9+RwBKtvadB6uKKQWKWB0JlRX3cFnGGkF9yNS1adLQfz36YkL/56gp/K1fC4uy9PArDopap3bGaLow2LO3eyglFzpieM50fDBnxZu3A+apW6aCsmrZzxA4fPfD9j4Cag4ssqJoMK0VlX5luofIqErInsw4sHsOdPlnAWVN+m0mKPFGb9U0PUC6iyE7tWPKNMt8++g25xadtqnhvxjKGG5GFOKGXegDUUX0ZwVf0yWJ1oXsMvsRJ5cZjrMb01lyuBg5KN5N5a7YOZeBAIpLHQ==";
        "mobile-dashboard1.build.mtv1.mozilla.com":
            hostkey => "mobile-dashboard1.build.mtv1.mozilla.com,10.250.48.16 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwydkyMMieRxDQWoSpx1Xfl9fdZwGzi5DcxUGLK5TQHG77Qe77KGIoOomyPPC0/knz96UuuJ/vSAo/JAkWIdVFnbs6pG2wmQBW4X2t4nLUu5iiEeub0TTGN0GqLd2p48wIoEJmTlc2r/aXzDjbwxUBV4P07YtL/oyFolu02WS4avTYJs4O84LuMiBnaLX4vb4baV77L0756SnOYbZejHXiw+BH+QioYUAeWSf6NfX/RKyuvpM+xrzb8t4+Ad9289WsCAYWBkVIi1zKKwDA372jTg5Iy8u4f4RfR4cgVSJRbZGBMJdYtlrrs6EIp6Yb2QRdsTpkvkDifVD3t9mYPqvtw==";
        "bm-remote-talos-webhost-02":
            hostkey => "bm-remote-talos-webhost-02.build.mozilla.org,10.250.50.171 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtS9lvNguh7cekRDdEpGAJACh8WPbrsbLmzdETL7CiCNfudXUQ1IFkAYjci2ufJp0n7ZHvm3YHpDBlgMzGW85vfszOdN+dXDGDb9rsyh+9C6B+v+2yg8YzS9IGl/GQoEFtBZqgu83a38jiXcqnYe8dx+D9Lrp4I/cDfgriXGXzxJpc+yBIO38lhnfo5vo0VKHFD5XNGq9edgwRDZ1vYXDfxgPftKFJiZkuFTTa9LBrSjx4DueUv0xYFCQ+8lUV1mvb71FfykvlpwK+uJBnDLMyyz+0Ab54uXnrAPYQ6J4OCa/ZpnQ5JpdxCFTYvGMWIbYMBWLeA80VE1FPNRoo1GWBQ==";
        "bm-remote-talos-webhost-03":
            hostkey => "bm-remote-talos-webhost-03.build.mozilla.org,10.250.50.172 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA4spGs7xzChHk5EwqZU4X2LM/nxkZSywIQsMvSnrYaQCewuc87vQzgp4RwTdKbrBCox9+RwBKtvadB6uKKQWKWB0JlRX3cFnGGkF9yNS1adLQfz36YkL/56gp/K1fC4uy9PArDopap3bGaLow2LO3eyglFzpieM50fDBnxZu3A+apW6aCsmrZzxA4fPfD9j4Cag4ssqJoMK0VlX5luofIqErInsw4sHsOdPlnAWVN+m0mKPFGb9U0PUC6iyE7tWPKNMt8++g25xadtqnhvxjKGG5GFOKGXegDUUX0ZwVf0yWJ1oXsMvsRJ5cZjrMb01lyuBg5KN5N5a7YOZeBAIpLHQ==";
    }
}
