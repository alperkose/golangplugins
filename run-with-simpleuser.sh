#!/bin/bash

pushd simpleuser

go build -o plugin.so -buildmode=plugin .
cp plugin.so ..

popd

go run main.go
