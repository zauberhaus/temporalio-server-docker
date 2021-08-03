#/bin/sh

VERSION=`cat version.txt`
REPO=https://github.com/temporalio/temporal.git

git clone ${REPO} src 
cd src 
echo "Checkout tag $VERSION" 
if [ "$VERSION" != "main" ] && [ ! -z "$VERSION" ] ; then git checkout tags/${VERSION} -b ${VERSION} ; fi

export BUILD_DATE=$(date '+%F-%T')
export BUILD_TS_UNIX=$(date '+%s')
export GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
export BUILD_PLATFORM=$(go version | cut -d ' ' -f 4)
export GO_VERSION=$(go version | cut -d ' ' -f 3)

goreleaser build --rm-dist -f ../goreleaser.yml
cp -r ./dist ..
cp -r ./config ..
cp -r ./docker ..
cp -r ./schema ..
