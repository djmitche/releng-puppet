class ssh::common_known_hosts($home, $owner, $group) {
    include concat::setup

    concat {
        "$home/.ssh/known_hosts":
            mode => 0644,
            owner => $owner,
            group => $group,
            require => Class['ssh::setup'];
    }
    ssh::known_host {
        "dev-stage01.srv.releng.scl3.mozilla.com":
            home => $home,
            hostkey => "dev-stage01.srv.releng.scl3.mozilla.com,10.26.48.44 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA80JxNARSnHo9ym5FI2vt/WQPkLTePgHxE9Iwafwz2SvAKs/bcz1rUZm+s1YUJ6Xm4i3w984T6q/KSEqOWcYY3HjZ8rntcehGO8zXIVQRI4U1v1TxCvrwsJ12z9NHNrzX+JGtjyb+5RgODNQm2A6klbu/sgVdwbCxTkvImNb281erYyNuwaZ7CvF2yYFzMYtuR0dGMO02aIzIO3phM2PM7bLtWgDZ/zjiFZcuCVcM6vY75sLYyoXPj+q+oezeU5/cksyInVvcwFJ7Jn5WwRD4anqWrIrKjlVNY6XQbPm5OHdw4mXzct6hrLaYdXloT9tgA/ktZ7NDqL6kxeBjplTQ4Q==";
        "stage.mozilla.org":
            home => $home,
            hostkey => "stage.mozilla.org,10.2.74.116 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA6JfgGmF83VqGJQNJUta7xCP4ZN6z9OITNMfk9E6lYcJmpDWn4JFxQdTj7BwzADwFtYP3jdkZZbYILhZ9OvTKyX1vlmuom9ukKZSdRtv+GwzI1dYNvYca5sC7LWmf/2UiUpwoWC42Ljuwru9mV4xQ2XkiLulDU6TK8wtjTfUp5T0=";
    }
}
