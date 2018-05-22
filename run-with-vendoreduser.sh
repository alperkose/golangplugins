#!/bin/bash

pushd vendoreduser
mkdir -p vendor/github.com/alperkose/golangplugins
cp -r ../user vendor/github.com/alperkose/golangplugins/

go build -o plugin.so -buildmode=plugin .
cp plugin.so ..

popd

go run main.go
