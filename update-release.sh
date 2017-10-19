#!/bin/bash -xe
current_release_version () {
  bosh2 -e vbox releases|grep mongodb|head -1|cut  -f2|cut -d "." -f2|sed "s/\*//"
}
mkdir -p dev_releases
rm -rf ./dev_releases/*/*gz
echo `current_release_version`
newVersion=$((`current_release_version`+1))
v=0+dev.$newVersion

bosh2 create-release --version=$v --force --tarball=./dev_releases/mongodb-release/mongodb-release-${v}.tgz
bosh2 -e vbox upload-release ./dev_releases/mongodb-release/mongodb-release-${v}.tgz
