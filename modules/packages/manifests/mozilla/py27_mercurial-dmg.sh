#! /bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

set -e

export PATH=`xcode-select -print-path`:/tools/packagemaker/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# variables to parallel the spec file
realname=mercurial
pyrealname=python27
pyver=2.7
pyhome=/tools/$pyrealname
python_sitelib=$pyhome/lib/python$pyver/site-packages
_prefix=/tools/${pyrealname}-${realname}
_libdir=$_prefix/lib
package_sitelib=$_libdir/python$pyver/site-packages
version=2.5.4
release=3
srpm_release=1  # use whatever version of the SRPM is on the server
xcode_vers=4.1
osx_vers=10.7.2

# ensure the same build environment (you can change this if necessary, just test carefully)
if [ ! -x /tools/packagemaker/bin/packagemaker ]; then
    echo "install the packagemaker package (also in puppetagain)"
    exit 1 
fi

if [ "$(sw_vers -productVersion)" != "$osx_vers" ]; then
    echo "Build this on a $osx_vers host"
    exit 1 
fi

if [ "$(xcodebuild -version | grep Xcode)" != "Xcode $xcode_vers" ]; then
    echo "Build this with Xcode $xcode_vers"
    exit 1 
fi

# set up a clean build dir
if test -d build; then
    rm -rf build
fi
mkdir build
BUILD=$PWD/build
cd $BUILD

# get the sources from the SRPM
curl http://puppetagain.pub.build.mozilla.org/data/repos/yum/releng/public/CentOS/6/x86_64/mozilla-python27-mercurial-$version-$srpm_release.el6.src.rpm | bsdtar -x

# %prep
tar -zxf $realname-$version.tar.gz
cd $realname-$version

PYTHON=/tools/$pyrealname/bin/python$pyver
if ! test -x $PYTHON; then
    echo "$pyrealname ($PYTHON) must be instaled"
    exit 1
fi

# %build
$PYTHON setup.py build

# %install
ROOT=$BUILD/root
$PYTHON setup.py install -O1 --prefix=$_prefix --root=$ROOT --record=INSTALLED_FILES
mkdir -p $ROOT/$python_sitelib
echo $package_sitelib > $ROOT/$python_sitelib/$realname.pth

# add /usr/local/bin links
mkdir -p $ROOT/usr/local/bin
ln -s $_prefix/bin/hg $ROOT/usr/local/bin/hg

# build the package
cd $BUILD
mkdir dmg
fullname=$pyrealname-$realname-$version-$release
pkg=dmg/$fullname.pkg
dmg=$fullname.dmg
packagemaker -r $ROOT -v -i com.mozilla.$pyrealname-$realname -o $pkg -l /
hdiutil makehybrid -hfs -hfs-volume-name "mozilla-$pyrealname-$realname-$version-$release" -o ./$dmg dmg
echo "Result:"
echo $PWD/$dmg
