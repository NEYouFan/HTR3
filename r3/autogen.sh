#!/bin/sh

set -ex
rm -rf autom4te.cache Makefile.in aclocal.m4
aclocal --force

# GNU libtool is named differently on some systems.  This code tries several
# variants like glibtoolize (MacOSX) and libtoolize1x (FreeBSD)

set +ex
set -ex

autoconf -f -W all,no-obsolete
autoheader -f -W all
# automake -a -c -f -W all
automake --add-missing --foreign --copy -c -W all

rm -rf autom4te.cache
exit 0

# end autogen.sh
