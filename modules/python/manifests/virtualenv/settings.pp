# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
# (private)
class python::virtualenv::settings {
    # the root package directory into which all Python package tarballs are copied
    $misc_python_dir = "/tools/misc-python"
    # the puppet URL for the python/packages downloads
    $packages_dir_source = "puppet:///python/packages"

    $pip_version = "0.8.2"
}
