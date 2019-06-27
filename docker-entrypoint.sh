#!/bin/sh

if [ "$#" -gt 0 ]; then
  exec "$@"
fi

set -ex
find /root/rpmbuild/SPECS -name '*.spec' | while read specfile; do
  spectool --get-files --all --sourcedir "$specfile"
  yum-builddep -y "$specfile"
  rpmbuild -bb "$specfile"
done
