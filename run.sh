#!/bin/sh +x

GO_VERSION=${1:-1.11}
docker build -q -t golangplugins-example --build-arg GO_VERSION=$GO_VERSION .

echo \# Go version
echo ------------
docker run --entrypoint go golangplugins-example version
echo 

echo \# Running with non-vendored implementation
echo ------------------------------------------
docker run golangplugins-example -plugin simpleuser.plugin
echo 

echo \# Running with implementation in different gopath
echo -------------------------------------------------
docker run golangplugins-example -plugin differentgopath.plugin

echo \# Running with vendored implementation
echo --------------------------------------
docker run golangplugins-example -plugin vendoreduser.plugin
echo 
