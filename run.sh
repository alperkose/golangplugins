#!/bin/sh +x

GO_VERSION=${1:-1.11}
docker build -t golangplugins-example --build-arg GO_VERSION=$GO_VERSION .

echo Go version
docker run --entrypoint go golangplugins-example version
echo 

echo Running with non-vendored implementation
docker run golangplugins-example -plugin simpleuser.plugin
echo 

echo Running with vendored implementation
docker run golangplugins-example -plugin vendoreduser.plugin